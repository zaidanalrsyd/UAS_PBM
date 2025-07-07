import '../models/product_model.dart';

class ProductService {
  static final List<Product> _products = [
    Product(
      id: 1,
      name: 'Tas Selempang',
      price: 150000,
      imageUrl: 'https://static.birudaun.net.consina.com/wp-content/uploads/2023/01/roky6-600x600.jpg',
    ),
    Product(
      id: 2,
      name: 'Tas Ransel',
      price: 200000,
      imageUrl: 'https://cf.shopee.co.id/file/265593d4a930c983041f16181c53facf',
    ),
  ];

  static List<Product> getProducts() {
    return List<Product>.from(_products);
  }

  static void addProduct(Product product) {
    _products.add(product);
  }

  static void updateProduct(Product updatedProduct) {
    int index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
    }
  }
}
