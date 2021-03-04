import 'package:flutter/material.dart';
import 'package:myshop/providers/auth.dart';
import 'package:myshop/screens/order/order_screen.dart';
import 'package:myshop/screens/product/product_overview_screen.dart';
import 'package:myshop/screens/product/user_product_screen.dart';

import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;

  int _selectedPagesIndex = 0;
  void _selectedPages(int index) {
    setState(() {
      _selectedPagesIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      {'pages': ProductOverviewScreen()},
      {'pages': OrderScreen()},
      {'pages': UserProduct()},
    ];
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: _pages[_selectedPagesIndex]['pages'],
      bottomNavigationBar: Container(
        height: deviceSize.height * 0.13,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            elevation: 5,
            backgroundColor: Theme.of(context).primaryColor,
            onTap: _selectedPages,
            iconSize: 20,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.yellow[900],
            unselectedItemColor: Colors.white,
            currentIndex: _selectedPagesIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.shop),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.payment),
                label: 'Orders',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.shopping_bag),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: FlatButton(
                  padding: EdgeInsets.only(),
                  child: Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/');
                    Provider.of<Auth>(context, listen: false).logout();
                  },
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
