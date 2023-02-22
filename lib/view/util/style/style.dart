import 'package:flutter/material.dart';

abstract class Style {
  static const primaryColor = Color(0xff767E8C);
  static const helperColor = Color(0xffE0E5ED);
  static const blackColor = Color(0xff1B1C1F);
  static const whiteColor = Colors.white;
  static const greyColor = Color.fromARGB(255, 223, 224, 226);


  static const primaryGradient = LinearGradient(colors: [
    Color(0x90A9B0C5),
    Color(0xffA9B0C5),
  ]);

  static const enabledGradient = LinearGradient(colors: [
    Color(0x60A9B0C5),
    Color(0x70A9B0C5),
  ]);

  static textStyleNormal(
          {double size = 16,
          Color textColor = blackColor,
          FontWeight fontWeight = FontWeight.w600,
          bool isDone = false}) =>
      TextStyle(
          fontSize: size,
          color: primaryColor,
          fontWeight: fontWeight,
          decoration:
              isDone ? TextDecoration.lineThrough : TextDecoration.none);

  static textStyleSemibold(
          {double size = 16,
          Color textColor = blackColor,
          FontWeight fontWeight = FontWeight.w600,
          bool isDone = false}) =>
      const TextStyle();

  static textStyleRegular({
    double size = 18,
    Color textColor = blackColor,
  }) =>
      TextStyle(
          fontWeight: FontWeight.w600, color: textColor, fontSize: size);

  static textStyleRegular2({
    double size = 16,
    Color textColor = blackColor,
  }) =>
      TextStyle(
          fontWeight: FontWeight.w600, color: textColor, fontSize: size);
}