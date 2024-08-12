import 'package:sqabyfood_sqaby/controller/product_controller.dart';
import 'package:sqabyfood_sqaby/data/model/body/review_body.dart';
import 'package:sqabyfood_sqaby/data/model/response/order_model.dart';
import 'package:sqabyfood_sqaby/util/dimensions.dart';
import 'package:sqabyfood_sqaby/util/styles.dart';
import 'package:sqabyfood_sqaby/view/base/custom_button.dart';
import 'package:sqabyfood_sqaby/view/base/custom_snackbar.dart';
import 'package:sqabyfood_sqaby/view/base/my_text_field.dart';
import 'package:sqabyfood_sqaby/view/screens/review/widget/delivery_man_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/model/response/submit_review_delivery_model.dart';
import '../../../../util/images.dart';
import '../../../base/confirmation_dialog.dart';

class DeliveryManReviewWidget extends StatefulWidget {
  final DeliveryMan? deliveryMan;
  final String orderID;
  final SubmitDeliveryReviewModel? submitDeliveryReviewModel;

  DeliveryManReviewWidget({required this.deliveryMan, required this.orderID,this.submitDeliveryReviewModel});

  @override
  State<DeliveryManReviewWidget> createState() =>
      _DeliveryManReviewWidgetState();
}

class _DeliveryManReviewWidgetState extends State<DeliveryManReviewWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (productController) {
      return Scrollbar(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        child: Center(
            child: SizedBox(
                width: Dimensions.WEB_MAX_WIDTH,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.deliveryMan != null
                          ? DeliveryManWidget(deliveryMan: widget.deliveryMan!)
                          : SizedBox(),
                      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                      Container(
                        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[Get.isDarkMode ? 700 : 300]!,
                              blurRadius: 5,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: Column(children: [
                          Text(
                            'rate_his_service'.tr,
                            style: robotoMedium.copyWith(
                                color: Theme.of(context).disabledColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                          SizedBox(
                            height: 30,
                            child: ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  child:
                                  !widget.submitDeliveryReviewModel!.submitted! ?
                                  Icon(
                                    productController.deliveryManRating < (i + 1) ? Icons.star_border : Icons.star,
                                    size: 25,
                                    color: productController.deliveryManRating < (i + 1) ? Theme.of(context).disabledColor
                                        : Theme.of(context).primaryColor,
                                  ) :

                                  Icon(
                                    widget.submitDeliveryReviewModel!.rating! < (i + 1) ? Icons.star_border : Icons.star,
                                    size: 25,
                                    color: widget.submitDeliveryReviewModel!.rating!
                                     < (i + 1) ? Theme.of(context).disabledColor
                                        : Theme.of(context).primaryColor,
                                  ),
                                  onTap: widget.submitDeliveryReviewModel!.submitted! ? null : () {
                                    productController.setDeliveryManRating(i + 1);
                                  },
                                );


                                // return InkWell(
                                //   child: Icon(
                                //     productController.deliveryManRating <
                                //             (i + 1)
                                //         ? Icons.star_border
                                //         : Icons.star,
                                //     size: 25,
                                //     color: productController.deliveryManRating <
                                //             (i + 1)
                                //         ? Theme.of(context).disabledColor
                                //         : Theme.of(context).primaryColor,
                                //   ),
                                //   onTap: () {
                                //     productController
                                //         .setDeliveryManRating(i + 1);
                                //   },
                                // );
                              },
                            ),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

                          Text(
                            'share_your_opinion'.tr,
                            style: robotoMedium.copyWith(
                                color: Theme.of(context).disabledColor),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                          ! widget.submitDeliveryReviewModel!.submitted! ?
                          MyTextField(
                            maxLines: 5,
                            capitalization: TextCapitalization.sentences,
                            controller: _controller,
                            hintText: 'write_your_review_here'.tr,
                            fillColor: Theme.of(context).disabledColor.withOpacity(0.05),
                          ) : MyTextField(
                            maxLines: 5,
                            capitalization: TextCapitalization.sentences,
                            controller: _controller,
                            isEnabled: false,
                            hintText: widget.submitDeliveryReviewModel!.comment!,
                            fillColor: Theme.of(context).disabledColor.withOpacity(0.05),
                          ),
                          SizedBox(height: 40),

                          // Submit button
                          !widget.submitDeliveryReviewModel!.submitted! ?
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                            child: Column(
                              children: [
                                !productController.isLoading ? CustomButton(
                                  buttonText: 'submit'.tr,
                                  onPressed: () {
                                    if (productController.deliveryManRating == 0) {
                                      showCustomSnackBar('give_a_rating'.tr);
                                    } else if (_controller.text.isEmpty) {
                                      showCustomSnackBar('write_a_review'.tr);
                                    } else {
                                      FocusScopeNode currentFocus = FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      Get.dialog(ConfirmationDialog(icon: Images.support, description: 'are_you_sure_review'.tr, isLogOut: false, onYesPressed: () {
                                        Get.back();
                                        ReviewBody reviewBody = ReviewBody(
                                          deliveryManId: widget.deliveryMan?.id.toString(),
                                          rating: productController.deliveryManRating.toString(),
                                          comment: _controller.text,
                                          orderId: widget.orderID,
                                        );
                                        productController.submitDeliveryManReview(reviewBody).then((value) {
                                          if (value.isSuccess!) {
                                            showCustomSnackBar(value.message, isError: false);
                                            widget.submitDeliveryReviewModel?.submitted = true ;
                                            widget.submitDeliveryReviewModel?.rating = productController.deliveryManRating;
                                            widget.submitDeliveryReviewModel?.comment = _controller.text;
                                            _controller.text = '';

                                          } else {
                                            showCustomSnackBar(value.message);
                                          }
                                        });
                                      }), useSafeArea: false);
                                    }
                                  },
                                ) : Center(child: CircularProgressIndicator()),
                              ],
                            ),
                          ) :   Padding(
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
                            child: Column(
                              children: [
                                !productController.isLoading ? CustomButton(
                                  buttonText: 'submitted'.tr,
                                  onPressed: null ,


                                ) : Center(child: CircularProgressIndicator()),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ]))),
      ));
    });
  }
}
