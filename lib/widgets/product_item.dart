import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/cart.dart';
import 'package:provider/provider.dart';
import '../models/product/product.dart';
import '../screens/product_detail.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => ProductDetailScreen(product: product),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: 90,
                height: 60,
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholder: (context, url) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.orange[900],
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          "Getting item image",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            product.title!,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: RatingBarIndicator(
                            rating: product.rating!.rate!,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Color(0xFFFFC107),
                            ),
                            itemCount: 5,
                            itemSize: 10.0,
                            direction: Axis.horizontal,
                          ),
                        ),
                        Container(
                          width: 80,
                          margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            '${product.price.toString()} Dollar',
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<Cart>(context, listen: false)
                          .addItem(product: product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            " we added to your cart!",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
