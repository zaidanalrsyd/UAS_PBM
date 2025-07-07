import 'package:flutter/material.dart';

class CartIcon extends StatelessWidget {
  final int itemCount;

  const CartIcon({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(Icons.shopping_cart),
        if (itemCount > 0)
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text('$itemCount', style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
          )
      ],
    );
  }
}