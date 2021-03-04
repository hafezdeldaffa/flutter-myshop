import 'package:flutter/foundation.dart';

class CartItems with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartItems({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItems> _items = {};

  Map<String, CartItems> get items {
    return {..._items};
  }

  int get itemsCount {
    var total = 0;
    _items.forEach((key, value) {
      total += value.quantity;
    });
    return total;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach(
      (key, cartItems) {
        total += cartItems.price * cartItems.quantity;
      },
    );
    return total;
  }

  void addItems(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItems) => CartItems(
          id: existingItems.id,
          title: existingItems.title,
          price: existingItems.price,
          quantity: existingItems.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItems(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1),
      );
    }
    notifyListeners();
  }

  void removeItems(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingItem) => CartItems(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
