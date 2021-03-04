import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myshop/helpers/custom_route.dart';
import 'package:myshop/providers/auth.dart';
import 'package:myshop/providers/cart.dart';
import 'package:myshop/providers/orders.dart';

import 'package:myshop/providers/product_provider.dart';
import 'package:myshop/screens/auth/auth_screen.dart';
import 'package:myshop/screens/cart/cart_screen.dart';
import 'package:myshop/screens/order/order_screen.dart';
import 'package:myshop/screens/product/edit_product_screen.dart';
import 'package:myshop/screens/product/product_detail_screen.dart';
import 'package:myshop/screens/product/product_overview_screen.dart';
import 'package:myshop/screens/product/user_product_screen.dart';

import 'package:myshop/screens/splash_screen.dart';
import 'package:myshop/widgets/utils/tabs_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          create: null,
          update: (context, authData, productProvider) => ProductProvider(
              authData.getToken,
              authData.userId,
              productProvider == null ? [] : productProvider.items),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: null,
          update: (context, authData, previewsOrders) => Orders(
              authData.getToken,
              authData.userId,
              previewsOrders == null ? [] : previewsOrders.order),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Color.fromRGBO(31, 52, 76, 1),
              accentColor: Color.fromRGBO(72, 66, 109, 1),
              textTheme: GoogleFonts.latoTextTheme(
                Theme.of(context).textTheme,
              ).copyWith(
                // ignore: deprecated_member_use
                title: GoogleFonts.lato(
                  // ignore: deprecated_member_use
                  textStyle: Theme.of(context).textTheme.title,
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
              pageTransitionsTheme: PageTransitionsTheme(
                  builders: ({
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              })),
              appBarTheme: AppBarTheme(
                textTheme: TextTheme(
                  // ignore: deprecated_member_use
                  title: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            home: authData.isAuth
                ? TabsScreen()
                : FutureBuilder(
                    future: authData.tryAutoLogin(),
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              ProductOverviewScreen.routeName: (context) =>
                  ProductOverviewScreen(),
              ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
              CartScreen.routeName: (context) => CartScreen(),
              OrderScreen.routeName: (contex) => OrderScreen(),
              UserProduct.routeName: (context) => UserProduct(),
              EditProductScreen.routeName: (context) => EditProductScreen(),
            },
          );
        },
      ),
    );
  }
}
