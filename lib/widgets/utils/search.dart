import 'package:flutter/material.dart';
import 'package:myshop/providers/product.dart';
import 'package:myshop/screens/product/product_detail_screen.dart';

class CustomSearch extends SearchDelegate<String> {
  final List<Product> items;

  CustomSearch(this.items);
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final suggestionList = items
        .where(
          (i) => i.title.toLowerCase().startsWith(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(suggestionList[index].imageUrl),
        ),
        onTap: () {
          Navigator.of(context).popAndPushNamed(ProductDetailScreen.routeName,
              arguments: suggestionList[index].id);
        },
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].title.substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: suggestionList[index].title.substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ],
          ),
        ),
      ),
    );
  }
}
