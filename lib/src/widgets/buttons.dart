import 'package:flutter/material.dart';

import 'package:userapp/src/utils/colors.dart';
import 'package:userapp/src/utils/styles.dart';

class Buttons {
  Widget circularButton(
    BuildContext context, {
    @required VoidCallback onPressed,
    @required String text,
    Color color = CustomColors.black1,
    Color textColor = CustomColors.white,
  }) =>
      RaisedButton(
        elevation: 0,
        color: color,
        shape: StadiumBorder(),
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(
              text,
              style: Styles.textButton(context, textColor: textColor),
            ),
          ),
        ),
      );
}

Buttons buttons = Buttons();
