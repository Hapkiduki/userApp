import 'package:flutter/material.dart';
import 'package:userapp/src/utils/dimensions.dart';
import 'package:userapp/src/utils/styles.dart';

class CustomDialogs {
  static showMessageDialog(message, context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: Dimensions.borderRadius(10.0),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'ACEPTAR',
                style: Styles.textLink(context),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
