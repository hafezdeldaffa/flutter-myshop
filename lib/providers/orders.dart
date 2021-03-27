import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:myshop/providers/cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItems> cartItems;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.cartItems,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  final String authToken;
  final String userId;

  Orders(this.authToken, this.userId, _orders);

  List<OrderItem> get order {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    // final stringUrl =
    //     'https://flutter-myshop-6969-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';

    // final url = Uri.https(
    //   'flutter-myshop-6969-default-rtdb.firebaseio.com',
    //   '/orders/$userId.json',
    //   {'auth': '$authToken'},
    // );

    final url = Uri.parse(
        'https://flutter-myshop-6969-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    try {
      final response = await http.get(url);
      final List<OrderItem> loadedOrders = [];
      final extractedOrders =
          json.decode(response.body) as Map<String, dynamic>;
      if (extractedOrders == null) {
        return;
      }
      extractedOrders.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            cartItems: (orderData['products'] as List<dynamic>)
                .map(
                  (items) => CartItems(
                    id: items['id'],
                    price: items['price'],
                    quantity: items['quantity'],
                    title: items['title'],
                  ),
                )
                .toList(),
            dateTime: DateTime.parse(orderData['dateTime']),
          ),
        );
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addOrder(List<CartItems> cartProduct, double total) async {
    try {
      final stringUrl =
          'https://flutter-myshop-6969-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken';

      final timeStamp = DateTime.now();
      final response = await http.post(
        // Uri.https(
        //   'flutter-myshop-6969-default-rtdb.firebaseio.com',
        //   '/orders/$userId.json',
        //   {'auth': '$authToken'},
        // ),

        Uri.parse(stringUrl),
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProduct
              .map(
                (cartItems) => {
                  'id': cartItems.id,
                  'title': cartItems.title,
                  'price': cartItems.price,
                  'quantity': cartItems.quantity,
                },
              )
              .toList(),
        }),
      );
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          cartItems: cartProduct,
          dateTime: DateTime.now(),
        ),
      );
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  void removeOrders(String orderId) {
    order.remove(orderId);
    notifyListeners();
  }
}
