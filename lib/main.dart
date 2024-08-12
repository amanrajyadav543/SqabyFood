import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:sqabyfood_sqaby/controller/auth_controller.dart';
import 'package:sqabyfood_sqaby/controller/cart_controller.dart';
import 'package:sqabyfood_sqaby/controller/localization_controller.dart';
import 'package:sqabyfood_sqaby/controller/location_controller.dart';
import 'package:sqabyfood_sqaby/controller/splash_controller.dart';
import 'package:sqabyfood_sqaby/controller/theme_controller.dart';
import 'package:sqabyfood_sqaby/controller/wishlist_controller.dart';
import 'package:sqabyfood_sqaby/helper/notification_helper.dart';
import 'package:sqabyfood_sqaby/helper/responsive_helper.dart';
import 'package:sqabyfood_sqaby/helper/route_helper.dart';
import 'package:sqabyfood_sqaby/theme/dark_theme.dart';
import 'package:sqabyfood_sqaby/theme/light_theme.dart';
import 'package:sqabyfood_sqaby/util/app_constants.dart';
import 'package:sqabyfood_sqaby/util/messages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'data/model/body/notification_body.dart';
import 'helper/get_di.dart' as di;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  if (ResponsiveHelper.isMobilePhone()) {
    HttpOverrides.global = new MyHttpOverrides();
  }
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();


  if(GetPlatform.isWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDPD5fXJkgICfQ9hUbyNyg4umCbFraEvoI",
          authDomain: "sqabyfood.firebaseapp.com",
          projectId: "sqabyfood",
          storageBucket: "sqabyfood.appspot.com",
          messagingSenderId: "455130785962",
          appId: "1:455130785962:web:c8b3fdca3cfdc5cdcc08d3",
          measurementId: "G-XKRTXVBC7Y"
      ),
    );
  }
    await Firebase.initializeApp();
  Map<String, Map<String, String>> _languages = await di.init();

  //int? _orderID;
  NotificationBody? body;

  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        // _orderID = remoteMessage.notification?.titleLocKey != null
        //     ? int.parse(remoteMessage.notification!.titleLocKey!)
        //     : null;
        body = NotificationHelper.convertNotification(remoteMessage.data);

      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (e) {}


  runApp(MyApp(languages: _languages, body: body));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  //final int? orderID;
  final  NotificationBody? body;

  MyApp({required this.languages, @required this.body});

  void _route() {
    Get.find<SplashController>().getConfigData().then((bool isSuccess) async {
      if (isSuccess) {
        if (Get.find<AuthController>().isLoggedIn()) {
          Get.find<AuthController>().updateToken();
          await Get.find<WishListController>().getWishList();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isWeb) {
      Get.find<SplashController>().initSharedData();
      if (Get.find<LocationController>().getUserAddress() != null &&
          (Get.find<LocationController>().getUserAddress()?.zoneIds == null ||
              Get.find<LocationController>().getUserAddress()?.zoneData ==
                  null)) {
        Get.find<AuthController>().clearSharedAddress();
      }
      Get.find<CartController>().getCartData();
      _route();
    }

    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetBuilder<SplashController>(builder: (splashController) {
          return (GetPlatform.isWeb && splashController.configModel == null)
              ? SizedBox()
              : GetMaterialApp(
                  title: AppConstants.APP_NAME,
                  debugShowCheckedModeBanner: false,
                  navigatorKey: Get.key,
                  scrollBehavior: MaterialScrollBehavior().copyWith(
                    dragDevices: {
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.touch
                    },
                  ),
                  theme: themeController.darkTheme ? dark : light,
                  locale: localizeController.locale,
                  translations: Messages(languages: languages),
                  fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
                      AppConstants.languages[0].countryCode),
                  initialRoute: GetPlatform.isWeb
                      ? RouteHelper.getInitialRoute()
                      : RouteHelper.getSplashRoute(body),
                  getPages: RouteHelper.routes,
                  defaultTransition: Transition.topLevel,
                  transitionDuration: Duration(milliseconds: 500),
                );
        });
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


