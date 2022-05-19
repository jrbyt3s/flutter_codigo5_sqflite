import 'package:flutter/material.dart';
import 'package:flutter_codigo5_sqflite/utils.dart/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTextFieldWidget extends StatelessWidget {
  String hintText;
  String icon;
  int? maxLines;
  TextEditingController? controller;

  InputTextFieldWidget({
    required this.hintText,
    required this.icon,
    this.maxLines,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: TextField(
        style: GoogleFonts.poppins(
          color: Colors.white,
        ),
        maxLines: maxLines,
        cursorColor: kSecondaryColor,
        controller: controller,
        toolbarOptions:
            ToolbarOptions(copy: true, paste: true, cut: true, selectAll: true
                //by default all are disabled 'false'
                ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Colors.white54,
            fontSize: 14,
          ),
          filled: true,
          fillColor: Color(0xff2A2D37),
          prefixIcon: SvgPicture.asset(
            'assets/images/$icon',
            color: Colors.white60,
            height: 10,
            fit: BoxFit.scaleDown,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
