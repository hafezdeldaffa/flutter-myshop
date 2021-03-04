import 'package:flutter/material.dart';
import 'package:myshop/providers/cart.dart';

import 'package:myshop/providers/product_provider.dart';
import 'package:myshop/screens/cart/cart_screen.dart';
import 'package:myshop/widgets/product/product_grid.dart';
import 'package:myshop/widgets/utils/badge.dart';
import 'package:myshop/widgets/utils/categories_item.dart';
import 'package:myshop/widgets/utils/container_title.dart';
import 'package:myshop/widgets/utils/search.dart';

import 'package:provider/provider.dart';

enum Filters { Favorite, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
  static const routeName = '/product-overview';
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorite = false;

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final items = Provider.of<ProductProvider>(context, listen: false).items;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        textTheme: TextTheme(
          // ignore: deprecated_member_use
          title: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text(
          'Tokoku',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearch(items));
            },
          ),
          PopupMenuButton(
            icon: const Icon(
              Icons.list,
              color: Colors.black,
            ),
            onSelected: (Filters selectedValue) {
              setState(() {
                if (selectedValue == Filters.Favorite) {
                  _showOnlyFavorite = true;
                } else {
                  _showOnlyFavorite = false;
                }
              });
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: Filters.Favorite,
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Theme.of(context).primaryColor,
                    ),
                    Padding(padding: const EdgeInsets.only(left: 5)),
                    const Text('Show Favorite'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: Filters.All,
                child: Row(
                  children: [
                    Icon(
                      Icons.all_out,
                      color: Theme.of(context).primaryColor,
                    ),
                    Padding(padding: const EdgeInsets.only(left: 5)),
                    const Text('Show All'),
                  ],
                ),
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (context, cart, child) => Badge(
              child: child,
              value: cart.itemsCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CategoriesItem(deviceSize: deviceSize),
            ContainerTitle('Products'),
            SizedBox(
              height: deviceSize.height * 0.34,
              child: FutureBuilder(
                future: Provider.of<ProductProvider>(context, listen: false)
                    .fetchAndSetProducts(),
                builder: (context, dataSnapshot) {
                  if (dataSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (dataSnapshot.connectionState == dataSnapshot.error) {
                      return Center(
                        child: Text('Error occured!'),
                      );
                    } else {
                      return RefreshIndicator(
                          onRefresh: () => _refreshProduct(context),
                          child: ProductGrid(_showOnlyFavorite));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
