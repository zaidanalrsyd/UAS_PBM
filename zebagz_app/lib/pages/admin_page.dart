import 'package:flutter/material.dart';
import '../services/local_db.dart';
import '../models/product_model.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();

  void _addProduct() async {
    final product = Product(
      name: _nameController.text,
      price: double.tryParse(_priceController.text) ?? 0,
      imageUrl: _imageController.text,
    );
    await LocalDB.insertProduct(product);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Produk ditambahkan')));
    _nameController.clear();
    _priceController.clear();
    _imageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Nama Tas')),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Harga')),
            TextField(controller: _imageController, decoration: const InputDecoration(labelText: 'URL Gambar')),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addProduct,
              child: const Text('Tambah Produk'),
            )
          ],
        ),
      ),
    );
  }
}
