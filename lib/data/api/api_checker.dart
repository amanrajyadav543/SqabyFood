import 'package:sqabyfood_sqaby/controller/auth_controller.dart';
import 'package:sqabyfood_sqaby/controller/wishlist_controller.dart';
import 'package:sqabyfood_sqaby/helper/route_helper.dart';
import 'package:sqabyfood_sqaby/view/base/custom_snackbar.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      Get.find<WishListController>().removeWishes();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
    } else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
