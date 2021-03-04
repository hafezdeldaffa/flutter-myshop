import 'package:flutter/material.dart';
import 'package:myshop/providers/auth.dart';
import 'package:myshop/screens/order/order_screen.dart';
import 'package:myshop/screens/product/product_overview_screen.dart';
import 'package:myshop/screens/product/user_product_screen.dart';

import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget listTile(String title, Icon icon, routeName) {
      return ListTile(
        leading: icon,
        title: Text(title),
        onTap: () {
          Navigator.of(context).pushReplacementNamed(routeName);
        },
      );
    }

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Welcome to Tokoku!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          listTile('Shop', Icon(Icons.shop_rounded),
              ProductOverviewScreen.routeName),
          const Divider(),
          listTile('Orders', Icon(Icons.payment), OrderScreen.routeName),
          const Divider(),
          listTile('Manage Products', Icon(Icons.shopping_bag),
              UserProduct.routeName),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          )
        ],
      ),
    );
  }
}
