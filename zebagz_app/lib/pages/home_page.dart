import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';
import 'login_page.dart';
import '../services/product_service.dart';

class HomePage extends StatefulWidget {
  final String role;
  const HomePage({super.key, required this.role});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [];

@override
void initState() {
  super.initState();
  _loadProducts();
}

void _loadProducts() {
  setState(() {
    _products = ProductService.getProducts();
  });
}

  void _showAddProductDialog() {
    final _nameController = TextEditingController();
    final _priceController = TextEditingController();
    final _imageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama Tas'),
            ),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga'),
            ),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(labelText: 'URL Gambar'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
           onPressed: () {
            final name = _nameController.text.trim();
            final price = double.tryParse(_priceController.text.trim()) ?? 0.0;
            final imageUrl = _imageController.text.trim();

            if (name.isNotEmpty && price > 0 && imageUrl.isNotEmpty) {
             final newProduct = Product(
              id: DateTime.now().millisecondsSinceEpoch,
              name: name,
              price: price,
              imageUrl: imageUrl,
            );

            ProductService.addProduct(newProduct);

            setState(() {
            _products = ProductService.getProducts();
         });

          Navigator.pop(context);
      }
    },

            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _editPriceDialog(Product product) {
    final _controller = TextEditingController(text: product.price.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Harga Produk'),
        content: TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Harga Baru'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final newPrice = double.tryParse(_controller.text);
              if (newPrice != null) {
                setState(() {
                  product.price = newPrice;
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAdmin = widget.role == 'admin';

    return Scaffold(
      appBar: AppBar(
        title: Text(isAdmin ? 'Zebagz Admin Panel' : 'Zebagz Store'),
        backgroundColor: isAdmin ? Colors.deepPurple : Colors.teal,
        actions: [
          if (isAdmin)
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Tambah Produk',
              onPressed: _showAddProductDialog,
            ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'logout') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'logout', child: Text('Logout')),
            ],
          ),
        ],
      ),
      body: _products.isEmpty
          ? const Center(child: Text('Belum ada produk.'))
          : Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: _products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final product = _products[index];
                  return GestureDetector(
                    onLongPress: isAdmin
                        ? () => _editPriceDialog(product)
                        : null,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ProductCard(product: product),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
