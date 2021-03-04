import 'package:flutter/material.dart';
import 'package:myshop/providers/product_provider.dart';
import 'package:myshop/screens/product/edit_product_screen.dart';
import 'package:myshop/widgets/product/user_product_item.dart';
import 'package:provider/provider.dart';

class UserProduct extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Products List',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_business_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: _refreshProduct(context),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProduct(context),
                    child: Consumer<ProductProvider>(
                      builder: (context, productData, _) => ListView.builder(
                        itemCount: productData.items.length,
                        itemBuilder: (context, index) => UserProductItem(
                          productData.items[index].id,
                          productData.items[index].title,
                          productData.items[index].imageUrl,
                          productData.items[index].price,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
