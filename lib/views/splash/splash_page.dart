import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/utils/app_colors.dart';

import '../../controllers/check_login_controller.dart';

class SplashPage extends StatelessWidget {
   SplashPage({Key? key}) : super(key: key);
final CheckLoginController _controller  = Get.put(CheckLoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Lottie.asset('assets/lottie_images/splash.json',height: 250,width: 250)),
          Text(
            "Movie Hub",
            style: GoogleFonts.poppins(color: AppColors.yellow,fontWeight: FontWeight.w900,fontSize:22),
          ),
        ],
      ),
    );
  }
}
