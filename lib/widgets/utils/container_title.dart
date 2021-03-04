import 'package:flutter/material.dart';

class ContainerTitle extends StatelessWidget {
  final String _title;

  ContainerTitle(this._title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _title,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            'Show More',
            style: TextStyle(
              color: Colors.red[700],
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
