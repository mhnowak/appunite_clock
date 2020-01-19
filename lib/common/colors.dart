import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MainColors {
  static Color lightOrDark(BuildContext context, final Color light, final Color dark) {
    return Theme.of(context).brightness == Brightness.light ? light : dark;
  }

  static const Color lightBackground = Color(0xFFF5F8FC);
  static const Color darkBackground = Color(0xFF03142A);

  /// Text
  static const Color lightTimeText = Color(0xFF03142A);
  static const Color darkTimeText = Color(0xFFFFFFFF);
  static const Color lightDayText = Color(0xFF285AE3);
  static const Color darkDayText = Color(0xFF78A5FF);
  static const Color lightDateText = Color(0xFF748192);
  static const Color darkDateText = Color(0xFFFFFFFF);
  static const Color colon = Color(0xFF748192);
  static const Color additionalInfoText = Color(0xFF87909C);

  /// Card
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color darkCardBackground = Color(0xFF102139);

  /// Divider
  static const Color lightDivider = Color(0xFFF0EFEF);
  static const Color darkDivider = Color(0xFF2E3B4E);

  /// Ellipses
  static const Color sun = Color(0xFFF9E741);
  static const Color sunSmall = Color(0xFFFFF41F);
  static const Color moon = Color(0xFFFFFFFF);
  static const Color moonGradientColor = Color(0xFFDEDEDE);
  static const Color flower = Color(0xFF707070);
}