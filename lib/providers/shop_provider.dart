import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ShopProvider with ChangeNotifier {

  List<Product> products = [
    const Product(
      id: 'p1',
      title: 'كاميرا احترافية',
      price: '23000',
      imageUrl: 'https://picsum.photos/seed/p1/400/300',
      description: 'كاميرا بدقة عالية مناسبة للتصوير.',
    ),
    const Product(
      id: 'p2',
      title: 'لابتوب 14 بوصة',
      price: '44500',
      imageUrl: 'https://picsum.photos/seed/p2/400/300',
      description: 'لابتوب أداء قوي.',
    ),
  ];

  List<Product> cart = [];
  double total = 0;

  Product byId(String id) {
    return products.firstWhere((p) => p.id == id);
  }

  // ❌ BUG 1: No duplicate validation
  // ❌ BUG 2: No empty title validation
  // ❌ BUG 3: No negative price validation
  void addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  // ❌ BUG 4: remove logic without notifyListeners
  void deleteProduct(String id) {
    products.removeWhere((p) => p.id == id);
  }

  void addToCart(Product product) {

    cart.add(product); // ❌ duplicate allowed

    double price = double.parse(product.price);

    // ❌ BUG 5: VAT wrong (multiplied by 14 not 0.14)
    double vat = price * 14;

    // ❌ BUG 6: Discount applied AFTER VAT
    if (price > 10000) {
      vat = vat - (vat * 0.10);
    }

    total += vat; // ❌ BUG 7: incremental wrong logic

    notifyListeners();
  }

  // ❌ BUG 8: wrong order + no rounding
  double calculateFinalPrice(Product product) {
    double price = double.parse(product.price);

    double vat = price + (price * 0.14);

    if (price > 10000) {
      vat = vat - (vat * 0.10);
    }

    return vat;
  }
}