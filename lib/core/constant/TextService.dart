import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Constant.dart';

class TextService {
  static var mediumText = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: whiteColor,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ));

  static var boldText = GoogleFonts.poppins(
      textStyle: TextStyle(
    color: whiteColor,
    fontSize: 17,
    fontWeight: FontWeight.bold,
  ));
}
