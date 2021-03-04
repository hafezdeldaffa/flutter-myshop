import 'package:flutter/material.dart';
import 'package:myshop/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'product_items.dart';

class ProductGrid extends StatelessWidget {
  final bool showOnlyFavorite;

  ProductGrid(this.showOnlyFavorite);

  @override
  Widget build(BuildContext context) {
    final productProviderData = Provider.of<ProductProvider>(context);
    final product = showOnlyFavorite
        ? productProviderData.favoriteItems
        : productProviderData.items;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: product[index],
        child: ProductItem(),
      ),
      padding: const EdgeInsets.all(10),
      itemCount: product.length,
    );
  }
}
