import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/utils/app_colors.dart';

class DetailWidget extends StatelessWidget {
  final String detail;
  final String value;

  const DetailWidget({
    super.key,
    required this.detail,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          detail,
          style: GoogleFonts.roboto(
            color: AppColors.yellow,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 5,),
        Text(
          value,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
