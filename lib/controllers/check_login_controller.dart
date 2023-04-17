import 'package:get/get.dart';
import '../views/home/home_page.dart';

class CheckLoginController extends GetxController {


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Get.offAll(() =>  HomePage());
    });
  }
}