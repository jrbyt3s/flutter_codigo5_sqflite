import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemBookWidget extends StatelessWidget {
  String title, image, author, description;
  ItemBookWidget({
    required this.title,
    required this.image,
    required this.author,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              width: 76,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  author,
                  style: GoogleFonts.poppins(
                      color: Colors.white60,
                      //fontWeight: FontWeight.w400,
                      fontSize: 13.0),
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0),
                ),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                      color: Colors.white60,
                      //fontWeight: FontWeight.w400,
                      fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
