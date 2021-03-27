import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String textContent;
  final bool _isError;

  Alert(this.textContent, this._isError);

  Widget _ifError(BuildContext context) {
    if (!_isError) {
      return Row(
        children: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('NO'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('YES'),
          ),
        ],
      );
    } else {
      return TextButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: const Text('YES'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Alert from Tokoku!',
        style: TextStyle(color: Colors.black),
      ),
      content: Text(textContent),
      actions: [_ifError(context)],
    );
  }
}
