import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData themeData = ThemeData(
  fontFamily: GoogleFonts.pTSans().fontFamily,
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(color: Colors.white),
  ),
  textTheme: TextTheme(
    title: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
    body1: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w300, color: Colors.white),
    body2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w200, color: Colors.white),
  ),
  cursorColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
  ),
);
