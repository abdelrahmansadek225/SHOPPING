import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/shop_provider.dart';

class ProductDetailsScreen extends StatelessWidget {

  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    final provider = context.read<ShopProvider>();

    // ❌ BUG 9: UI calculating logic directly
    double price = double.parse(product.price);
    double finalPrice = price * 14;

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          Image.network(product.imageUrl),

          const SizedBox(height: 12),

          Text(product.title),

          Text("Original Price: ${product.price} LE"),

          // ❌ wrong color + wrong logic
          Text(
            "Final Price: $finalPrice",
            style: const TextStyle(color: Colors.red),
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              provider.addToCart(product);
            },
            child: const Text("Add To Cart"),
          ),
        ],
      ),
    );
  }
}