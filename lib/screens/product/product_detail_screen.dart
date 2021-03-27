import 'package:flutter/material.dart';
import 'package:myshop/providers/auth.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/product.dart';
import 'package:myshop/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail-screen';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedData =
        Provider.of<ProductProvider>(context, listen: false).finById(productId);
    final mediaQuery = MediaQuery.of(context);
    final authData = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(loadedData.title),
      // ),
      body: ChangeNotifierProvider.value(
        value: loadedData,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: mediaQuery.size.height * 0.4,
              pinned: true,
              iconTheme: IconThemeData(color: Colors.black),
              actionsIconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.black,
              actions: [
                Consumer<Product>(
                  builder: (ctx, product, _) => IconButton(
                    icon: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      product.toogleFavorite(
                          authData.getToken, authData.userId);
                    },
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: loadedData.id,
                  child: Image.network(
                    loadedData.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: mediaQuery.size.height * 0.36,
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(55),
                          topLeft: Radius.circular(55)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: mediaQuery.size.height * 0.03,
                        ),
                        Text(
                          '${loadedData.title}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: mediaQuery.size.height * 0.03,
                        ),
                        Text(
                          '\$${loadedData.price}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: mediaQuery.size.height * 0.03,
                        ),
                        Text(
                          '${loadedData.description}',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Consumer<CartProvider>(
                      builder: (context, cart, _) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        child: const Text(
                          'Add to cart',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          cart.addItems(loadedData.id, loadedData.title,
                              loadedData.price);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Sucessfully added to cart!'),
                              action: SnackBarAction(
                                label: 'UNDO',
                                textColor: Colors.white,
                                onPressed: () {
                                  cart.removeSingleItem(loadedData.id);
                                },
                              ),
                            ),
                          );
                          // Scaffold.of(context).hideCurrentSnackBar();
                          // Scaffold.of(context).showSnackBar();
                        },
                      ),
                    ),
                    height: mediaQuery.size.height * 0.20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
