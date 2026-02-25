import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shop_provider.dart';
import '../widgets/product_card.dart';
import 'product_details_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.watch<ShopProvider>().products;

    return Scaffold(
     appBar: AppBar(
  title: const Text('Welcome'),
  actions: [

    // ❌ BUG 10: not formatted + no currency
    Center(child: Text(provider.total.toString())),

    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.logout),
    )
  ],
),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 3 / 4,
        ),
        itemCount: items.length,
        itemBuilder: (_, i) {
          final p = items[i]; // ← هنا المنتج
          return ProductCard(
            title: p.title,
            price: p.price,
            imageUrl: p.imageUrl,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailsScreen(product: p), // ← نمرّر المنتج
                ),
              );
            },
          );
        },
      ),
    );
  }
}
