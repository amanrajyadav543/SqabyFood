
import 'package:country_code_picker/country_code.dart';
import 'package:sqabyfood_sqaby/controller/auth_controller.dart';
import 'package:sqabyfood_sqaby/controller/splash_controller.dart';
import 'package:sqabyfood_sqaby/data/model/body/signup_body.dart';
import 'package:sqabyfood_sqaby/helper/responsive_helper.dart';
import 'package:sqabyfood_sqaby/helper/route_helper.dart';
import 'package:sqabyfood_sqaby/util/dimensions.dart';
import 'package:sqabyfood_sqaby/util/images.dart';
import 'package:sqabyfood_sqaby/util/styles.dart';
import 'package:sqabyfood_sqaby/view/base/custom_button.dart';
import 'package:sqabyfood_sqaby/view/base/custom_snackbar.dart';
import 'package:sqabyfood_sqaby/view/base/custom_text_field.dart';
import 'package:sqabyfood_sqaby/view/base/web_menu_bar.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../util/app_constants.dart';

class SignUpScreen extends StatefulWidget {
  final String number;
  SignUpScreen({required this.number});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _number;

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _referCodeFocus = FocusNode();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _referCodeController = TextEditingController();
  String? _countryDialCode;

  @override
  void initState() {
    super.initState();

    _number = widget.number.startsWith('+') ? widget.number : '+'+widget.number.substring(1, widget.number.length);
    _countryDialCode = CountryCode.fromCountryCode(
            Get.find<SplashController>().configModel!.country!)
        .dialCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
      body: SafeArea(
          child: Scrollbar(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Container(
              width: context.width > 700 ? 700 : context.width,
              padding: context.width > 700
                  ? EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT)
                  : null,
              decoration: context.width > 700
                  ? BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[Get.isDarkMode ? 700 : 300]!,
                            blurRadius: 5,
                            spreadRadius: 1)
                      ],
                    )
                  : null,
              child: GetBuilder<AuthController>(builder: (authController) {
                return Column(children: [
                  Image.asset(Images.logo, width: 100),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Text(AppConstants.APP_NAME, style: robotoMedium.copyWith(fontSize: 25)),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                  Text('user_details'.tr,
                      style: robotoBlack.copyWith(fontSize: 30)),
                  SizedBox(height: 50),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                            spreadRadius: 1,
                            blurRadius: 5)
                      ],
                    ),
                    child: Column(children: [

                      CustomTextField(
                        hintText: 'first_name'.tr,
                        controller: _firstNameController,
                        focusNode: _firstNameFocus,
                        nextFocus: _lastNameFocus,
                        inputType: TextInputType.name,
                        capitalization: TextCapitalization.words,
                        prefixIcon: Images.user,
                        divider: true,
                      ),

                      CustomTextField(
                        hintText: 'last_name'.tr,
                        controller: _lastNameController,
                        focusNode: _lastNameFocus,
                        nextFocus: _emailFocus,
                        inputType: TextInputType.name,
                        capitalization: TextCapitalization.words,
                        prefixIcon: Images.user,
                        divider: true,
                      ),

                      CustomTextField(
                        hintText: 'email'.tr,
                        controller: _emailController,
                        focusNode: _emailFocus,
                        nextFocus: _referCodeFocus,
                        inputType: TextInputType.emailAddress,
                        prefixIcon: Images.mail,
                        divider: true,
                      ),






                      (Get.find<SplashController>().configModel?.refEarningStatus == 1 ) ? CustomTextField(
                        hintText: 'refer_code'.tr,
                        controller: _referCodeController,
                        focusNode: _referCodeFocus,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.text,
                        capitalization: TextCapitalization.words,
                        prefixIcon: Images.refer_code,
                        divider: false,
                        prefixSize: 14,
                      ) : SizedBox(),

                    ]),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_LARGE),



                  !authController.isLoading ? Row(children: [
                    // Expanded(child: CustomButton(
                    //   buttonText: 'sign_in'.tr,
                    //   transparent: true,
                    //   onPressed: () =>Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.signUp)),
                    // )),
                    Expanded(child: CustomButton(
                      buttonText: 'continue'.tr,
                      onPressed:  () => _register(authController, _countryDialCode!),
                    )),
                  ]) : Center(child: CircularProgressIndicator()),
                  SizedBox(height: 30),

                  // SocialLoginWidget(),

                  // GuestButton(),
                ]);
              }),
            ),
          ),
        ),
      )),
    );
  }

  void _register(AuthController authController, String countryCode) async {
    String _firstName = _firstNameController.text.trim();
    String _lastName = _lastNameController.text.trim();
    String _email = _emailController.text.trim();
    String _referCode = _referCodeController.text.trim();



    if (_firstName.isEmpty) {
      showCustomSnackBar('enter_your_first_name'.tr);
    }else if (_lastName.isEmpty) {
      showCustomSnackBar('enter_your_last_name'.tr);
    }else if (_email.isEmpty) {
      showCustomSnackBar('enter_email_address'.tr);
    }else if (!GetUtils.isEmail(_email)) {
      showCustomSnackBar('enter_a_valid_email_address'.tr);
    }else if (_referCode.isNotEmpty && _referCode.length != 10) {
      showCustomSnackBar('invalid_refer_code'.tr);
    }else {
      SignUpBody signUpBody = SignUpBody(
          fName: _firstName, lName: _lastName, email: _email, refCode: _referCode,phone: _number
      );
      authController.registration(signUpBody).then((status) async {
        if (status.isSuccess!) {
          //   if(Get.find<SplashController>().configModel.customerVerification) {
          //
          // //    Get.toNamed(RouteHelper.getVerificationRoute(_numberWithCountryCode, RouteHelper.signUp));
          //   }else {
          Get.toNamed(RouteHelper.getAccessLocationRoute(RouteHelper.signUp));
          // }
        }else {
          showCustomSnackBar(status.message);
        }
      });
    }
  }
}
