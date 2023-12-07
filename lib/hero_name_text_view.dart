import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroNameTextView extends StatelessWidget {
  const HeroNameTextView(
      {super.key, required this.heroName, this.color = Colors.black});
  final String heroName;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      heroName,
      style: GoogleFonts.inter(
          fontWeight: FontWeight.w700, fontSize: 18, color: color),
    );
  }
}
