import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorAlert {
  BuildContext _context;

  ErrorAlert(this._context);

  show(String message) {
    showDialog(
      barrierDismissible: false,
      context: _context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
