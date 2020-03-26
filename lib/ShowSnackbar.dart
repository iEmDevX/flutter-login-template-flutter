import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowSnackbar {
  // ---- Use ----
  // GlobalKey<ScaffoldState> _key = GlobalKey();
  //
  // final bar = ShowSnackbar().snackSample("กรุณากรอกข้อมูลให้ครบ");
  //   _key.currentState.show(bar);
  //
  // Scaffold(
  //       key: _key,
  //

  Widget show(String text, {Color color = Colors.green}) {
    return SnackBar(
      content: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: GoogleFonts.pTSans().fontFamily,
        ),
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: color.withOpacity(0.7),
    );
  }
}
