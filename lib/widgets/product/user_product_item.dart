import 'package:flutter/material.dart';
import 'package:myshop/providers/product_provider.dart';

import 'package:myshop/screens/product/edit_product_screen.dart';

import 'package:provider/provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final double price;

  UserProductItem(this.id, this.title, this.imageUrl, this.price);

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return RefreshIndicator(
      onRefresh: () => _refreshProduct(context),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            ),
            title: Text(title),
            subtitle: Text('\$$price'),
            trailing: Container(
              width: mediaQuery.size.width * 0.3,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      try {
                        await Provider.of<ProductProvider>(context,
                                listen: false)
                            .removeProduct(id);
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleting failed!'),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          EditProductScreen.routeName,
                          arguments: id);
                    },
                    icon: Icon(
                      Icons.edit_sharp,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
