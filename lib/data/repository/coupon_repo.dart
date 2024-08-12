import 'package:sqabyfood_sqaby/data/api/api_client.dart';
import 'package:sqabyfood_sqaby/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CouponRepo {
  final ApiClient apiClient;
  CouponRepo({required this.apiClient});

  Future<Response> getCouponList() async {
    return await apiClient.getData(AppConstants.COUPON_URI);
  }

  Future<Response> applyCoupon(String couponCode, int restaurantID) async {
    return await apiClient.getData(
        '${AppConstants.COUPON_APPLY_URI}$couponCode&restaurant_id=$restaurantID');
  }
}
