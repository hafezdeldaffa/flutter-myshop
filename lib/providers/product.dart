import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  void _favVal(bool _oldStatus) {
    isFavorite = _oldStatus;
    notifyListeners();
  }

  Future<void> toogleFavorite(String token, String userId) async {
    final _oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final stringUrl =
        'https://flutter-myshop-6969-default-rtdb.firebaseio.com/userFavorite/$userId/$id.json?auth=$token';

    try {
      final response = await http.put(
        // Uri.https(
        //   'flutter-myshop-6969-default-rtdb.firebaseio.com',
        //   '/userFavorite/$userId/$id.json',
        //   {'auth': '$token'},
        // ),

        Uri.parse(stringUrl),
        body: json.encode(isFavorite),
      );
      if (response.statusCode >= 400) {
        _favVal(_oldStatus);
      }
    } catch (e) {
      _favVal(_oldStatus);
      throw e;
    }
  }
}
