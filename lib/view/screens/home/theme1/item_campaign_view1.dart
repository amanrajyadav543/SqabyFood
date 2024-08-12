import 'package:sqabyfood_sqaby/controller/campaign_controller.dart';
import 'package:sqabyfood_sqaby/controller/splash_controller.dart';
import 'package:sqabyfood_sqaby/helper/responsive_helper.dart';
import 'package:sqabyfood_sqaby/helper/route_helper.dart';
import 'package:sqabyfood_sqaby/util/dimensions.dart';
import 'package:sqabyfood_sqaby/view/base/custom_image.dart';
import 'package:sqabyfood_sqaby/view/base/product_bottom_sheet.dart';
import 'package:sqabyfood_sqaby/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

import '../../../../util/styles.dart';
import '../../restaurant/restaurant_screen.dart';

class ItemCampaignView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CampaignController>(builder: (campaignController) {
      return (campaignController.itemCampaignList != null &&
              campaignController.itemCampaignList?.length == 0)
          ? SizedBox()
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('campaigns'.tr,
            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
         SizedBox(),
      ]),

                ),
                SizedBox(
                  height: 150,
                  child: campaignController.itemCampaignList != null
                      ? ListView.builder(
                          controller: ScrollController(),
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(
                              left: Dimensions.PADDING_SIZE_SMALL),
                          itemCount:
                              campaignController.itemCampaignList!.length > 10
                                  ? 10
                                  : campaignController.itemCampaignList!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: Dimensions.PADDING_SIZE_SMALL,
                                  bottom: 5),
                              child: InkWell(
                                onTap: () {
                                  if (campaignController.itemCampaignList![index].product != null) {
                                    ResponsiveHelper.isMobile(context)
                                        ? Get.bottomSheet(
                                      ProductBottomSheet(
                                          product: campaignController
                                              .itemCampaignList![index].product!,
                                         ),
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                    )
                                        : Get.dialog(
                                      Dialog(
                                          child: ProductBottomSheet(
                                              product: campaignController
                                                  .itemCampaignList![index].product!,
                                              )),
                                    );
                                  }else{
                                    Get.toNamed(
                                      RouteHelper.getRestaurantRoute(campaignController.itemCampaignList![index].restaurant!.id!),
                                      arguments: RestaurantScreen(restaurant: campaignController.itemCampaignList![index].restaurant!),
                                    );
                                  }



                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.RADIUS_SMALL),
                                  child: CustomImage(
                                    image:
                                        '${Get.find<SplashController>().configModel?.baseUrls?.campaignImageUrl}'
                                        '/${campaignController.itemCampaignList?[
                                          index].image}',
                                    height: 150,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : ItemCampaignShimmer(
                          campaignController: campaignController),
                ),
              ],
            );
    });
  }
}

class ItemCampaignShimmer extends StatelessWidget {
  final CampaignController campaignController;
  ItemCampaignShimmer({required this.campaignController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled: campaignController.itemCampaignList == null,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                color: Colors.grey[300],
              ),
            ),
          ),
        );
      },
    );
  }
}
