// lib/services/cart_service.dart
import '../models/cart_item.dart';
import '../models/product_model.dart';

class CartService {
  static final List<CartItem> _items = [];

  static List<CartItem> get items => _items;

  static void addToCart(Product product) {
    final index = _items.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      _items[index].quantity += 1;
    } else {
      _items.add(CartItem(product: product));
    }
  }

  static void removeFromCart(Product product) {
    _items.removeWhere((item) => item.product.id == product.id);
  }

  static void clearCart() {
    _items.clear();
  }

  static double get total => _items.fold(
        0,
        (sum, item) => sum + item.product.price * item.quantity,
      );
}
