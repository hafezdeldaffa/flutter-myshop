import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart' show CartProvider;
import 'package:myshop/providers/orders.dart';
import 'package:myshop/widgets/cart/cart_item.dart';

import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Cart Screen'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 3,
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total :',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  SizedBox(
                    width: mediaQuery.size.width * 0.1,
                  ),
                  Consumer<CartProvider>(
                    builder: (_, cart, child) => Chip(
                      label: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Theme.of(context).accentColor,
                    ),
                  ),
                  OrdersButton(cart: cart),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => CartItem(
              cart.items.values.toList()[index].id,
              cart.items.keys.toList()[index],
              cart.items.values.toList()[index].title,
              cart.items.values.toList()[index].quantity,
              cart.items.values.toList()[index].price,
            ),
            itemCount: cart.items.length,
          ))
        ],
      ),
    );
  }
}

class OrdersButton extends StatefulWidget {
  const OrdersButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  _OrdersButtonState createState() => _OrdersButtonState();
}

class _OrdersButtonState extends State<OrdersButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalAmount);
              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
            },
      child: _isLoading
          ? CircularProgressIndicator()
          : const Text(
              'ORDER NOW!',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
    );
  }
}
