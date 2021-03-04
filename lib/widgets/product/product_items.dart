import 'package:flutter/material.dart';

import 'package:myshop/providers/product.dart';
import 'package:myshop/screens/product/product_detail_screen.dart';

import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);

    final deviceSize = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
        },
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Card(
                borderOnForeground: true,
                child: Row(
                  children: [
                    Container(
                      height: deviceSize.height * 0.23,
                      width: deviceSize.width * 0.25,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Container(
                            child: Hero(
                              tag: product.id,
                              child: FadeInImage(
                                placeholder: AssetImage(
                                    'assets/images/product-placeholder.png'),
                                image: NetworkImage(
                                  product.imageUrl,
                                ),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            product.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff676767),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Consumer<CartProvider>(
//                             builder: (context, cart, _) => IconButton(
//                               icon: Icon(Icons.shopping_cart,
//                                   color: Colors.deepOrange),
//                               onPressed: () {
//                                 cart.addItems(
//                                     product.id, product.title, product.price);
//                                 Scaffold.of(context).hideCurrentSnackBar();
//                                 Scaffold.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text('Sucessfully added to cart!'),
//                                     action: SnackBarAction(
//                                       label: 'UNDO',
//                                       textColor: Colors.white,
//                                       onPressed: () {
//                                         cart.removeSingleItem(product.id);
//                                       },
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           Consumer<Product>(
//                             builder: (context, product, _) {
//                               return IconButton(
//                                 icon: Icon(
//                                   product.isFavorite
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: Colors.deepOrange,
//                                 ),
//                                 onPressed: () {
//                                   product.toogleFavorite(
//                                       authToken.getToken, authToken.userId);
//                                 },
//                               );
//                             },
//                           ),
