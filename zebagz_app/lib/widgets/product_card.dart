import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../pages/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Card(
        child: Column(
          children: [
            Image.network(product.imageUrl, height: 100),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(product.name, maxLines: 1),
                  Text('Rp ${product.price.toStringAsFixed(0)}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
