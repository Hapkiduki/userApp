import 'package:flutter/material.dart';

import 'package:userapp/src/utils/colors.dart';
import 'package:userapp/src/utils/dimensions.dart';
import 'package:userapp/src/utils/styles.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextInputType keyboardType;
  final bool isPassword;
  final Function(String) validator;
  final Function(String) onSaved;

  const CustomInput(
      {Key key,
      @required this.icon,
      @required this.placeholder,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.validator,
      this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          icon,
          color: CustomColors.yellow,
          size: 30,
        ),
        SizedBox(
          width: Dimensions.width(context) * .05,
        ),
        Flexible(
          child: TextFormField(
            obscureText: isPassword,
            onSaved: onSaved,
            validator: validator,
            keyboardType: keyboardType,
            style: Styles.textField(context),
            decoration: InputDecoration(
              hintText: placeholder,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.blue, width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
