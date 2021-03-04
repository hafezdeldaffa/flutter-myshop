import 'package:flutter/material.dart';

import 'package:myshop/widgets/utils/alert.dart';
import 'package:provider/provider.dart';
import 'package:myshop/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;

  CartItem(this.id, this.productId, this.title, this.quantity, this.price);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false)
            .removeItems(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) {
            return Alert('Do you want to remove this item from cart?', false);
          },
        );
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete_sweep_rounded,
          size: 40,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        padding: const EdgeInsets.only(right: 10),
      ),
      child: Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 23,
              backgroundColor: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    '\$$price',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total : ${(price * quantity)}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
