import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(product.imageUrl, height: 200),
            const SizedBox(height: 10),
            Text(product.name, style: Theme.of(context).textTheme.titleLarge),
            Text('Rp ${product.price.toStringAsFixed(0)}'),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: const Text('Tambahkan ke Keranjang')),
          ],
        ),
      ),
    );
  }
}
