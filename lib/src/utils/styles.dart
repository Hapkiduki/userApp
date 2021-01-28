import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:userapp/src/utils/colors.dart';
import 'package:userapp/src/utils/dimensions.dart';

class Styles {
  static textTitle(BuildContext context) => GoogleFonts.montserrat(
        color: CustomColors.white,
        fontSize: Dimensions.width(context) * .10,
        fontWeight: FontWeight.bold,
      );

  static textBody(BuildContext context) => GoogleFonts.montserrat(
        color: CustomColors.black2,
        fontSize: Dimensions.width(context) * .042,
        fontWeight: FontWeight.w500,
      );

  static textButton(BuildContext context, {@required Color textColor}) =>
      GoogleFonts.montserrat(
        color: textColor,
        fontSize: Dimensions.width(context) * .05,
        fontWeight: FontWeight.w600,
      );

  static textsubtitle(BuildContext context) => GoogleFonts.montserrat(
        color: CustomColors.black2,
        fontSize: Dimensions.width(context) * .05,
        fontWeight: FontWeight.w600,
      );

  static textMini(BuildContext context) => GoogleFonts.montserrat(
        color: CustomColors.black2.withOpacity(.4),
        fontSize: Dimensions.width(context) * .035,
        fontWeight: FontWeight.w500,
      );

  static textLink(BuildContext context) => GoogleFonts.montserrat(
        color: CustomColors.yellow,
        fontSize: Dimensions.width(context) * .035,
        fontWeight: FontWeight.bold,
      );

  static textField(BuildContext context) => GoogleFonts.montserrat(
        color: CustomColors.blue,
        fontSize: Dimensions.width(context) * .04,
      );

  static itemtitle(BuildContext context) => GoogleFonts.montserrat(
        color: CustomColors.black1,
        fontSize: Dimensions.width(context) * .03,
        fontWeight: FontWeight.bold,
      );

  static itemSubtitle(BuildContext context) => GoogleFonts.montserrat(
        color: CustomColors.black1,
        fontSize: Dimensions.width(context) * .025,
        fontWeight: FontWeight.w400,
      );

  static itemMenu(BuildContext context) => GoogleFonts.montserrat(
        color: CustomColors.black1,
        fontSize: Dimensions.width(context) * .035,
        fontWeight: FontWeight.w500,
      );
}
