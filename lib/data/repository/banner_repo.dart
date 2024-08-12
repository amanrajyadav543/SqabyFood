import 'package:sqabyfood_sqaby/data/api/api_client.dart';
import 'package:sqabyfood_sqaby/util/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class BannerRepo {
  final ApiClient apiClient;
  BannerRepo({required this.apiClient});

  Future<Response> getBannerList() async {
    return await apiClient.getData(AppConstants.BANNER_URI);
  }
}
