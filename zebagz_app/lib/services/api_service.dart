import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com/products';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Product(
        id: json['id'],
        name: json['title'],
        price: double.tryParse(json['price'].toString()) ?? 0,
        imageUrl: json['image'],
      )).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
