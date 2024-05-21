import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static TextStyle h1({Color? color}) => GoogleFonts.roboto(
        fontSize: 80,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle h2({Color? color}) => GoogleFonts.roboto(
        fontSize: 66,
        fontWeight: FontWeight.w200,
        color: color,
      );

  static TextStyle h3({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.roboto(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle subtitle21({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.roboto(
        fontSize: 21,
        fontWeight: FontWeight.w400,
        height: 1,
        color: color,
      );

  static TextStyle subtitle22({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.roboto(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1,
        color: color,
      );

  static TextStyle subtitle20({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1,
        color: color,
      );

  static TextStyle subtitle({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.roboto(
        fontSize: 18,
        fontWeight: fontWeight ?? FontWeight.w500,
        height: 1,
        color: color,
      );

  static TextStyle callout14({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.w100,
        color: color,
      );

  static TextStyle callout({Color? color, FontWeight? fontWeight}) =>
      GoogleFonts.roboto(
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color,
      );

  static TextStyle caption({Color? color}) => GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle lable({Color? color}) => GoogleFonts.roboto(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle small({Color? color}) => GoogleFonts.roboto(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: color,
      );
}
