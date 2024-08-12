import 'package:sqabyfood_sqaby/controller/campaign_controller.dart';
import 'package:sqabyfood_sqaby/controller/product_controller.dart';
import 'package:sqabyfood_sqaby/controller/splash_controller.dart';
import 'package:sqabyfood_sqaby/controller/theme_controller.dart';
import 'package:sqabyfood_sqaby/helper/price_converter.dart';
import 'package:sqabyfood_sqaby/helper/responsive_helper.dart';
import 'package:sqabyfood_sqaby/helper/route_helper.dart';
import 'package:sqabyfood_sqaby/util/dimensions.dart';
import 'package:sqabyfood_sqaby/util/styles.dart';
import 'package:sqabyfood_sqaby/view/base/custom_image.dart';
import 'package:sqabyfood_sqaby/view/base/discount_tag.dart';
import 'package:sqabyfood_sqaby/view/base/not_available_widget.dart';
import 'package:sqabyfood_sqaby/view/base/product_bottom_sheet.dart';
import 'package:sqabyfood_sqaby/view/base/rating_bar.dart';
import 'package:sqabyfood_sqaby/view/base/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

import '../../restaurant/restaurant_screen.dart';

class ItemCampaignView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

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
                          controller: _scrollController,
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
                                child: Container(
                                  height: 150,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.RADIUS_SMALL),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[
                                            Get.find<ThemeController>()
                                                    .darkTheme
                                                ? 700
                                                : 300]!,
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Stack(children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(
                                                    Dimensions.RADIUS_SMALL)),
                                            child: CustomImage(
                                              image:
                                                  '${Get.find<SplashController>().configModel!.baseUrls!.
                                                  campaignImageUrl}'
                                                  '/${campaignController.itemCampaignList![index].image}',
                                              height: 90,
                                              width: 130,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ]),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: Dimensions
                                                    .PADDING_SIZE_EXTRA_SMALL),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    campaignController
                                                        .itemCampaignList![index]
                                                        .title!,
                                                    style:
                                                        robotoMedium.copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeSmall),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    campaignController
                                                        .itemCampaignList![index]
                                                        .description!,
                                                    style: robotoMedium.copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeExtraSmall,
                                                        color: Theme.of(context)
                                                            .disabledColor),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 2),

                                                ]),
                                          ),
                                        ),
                                      ]),
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
        return Container(
          height: 150,
          width: 130,
          margin:
              EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL, bottom: 5),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[
                        Get.find<ThemeController>().darkTheme ? 700 : 300]!,
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled: campaignController.itemCampaignList == null,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 90,
                width: 130,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(Dimensions.RADIUS_SMALL)),
                    color: Colors.grey[
                        Get.find<ThemeController>().darkTheme ? 700 : 300]),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 10,
                            width: 100,
                            color: Colors.grey[
                                Get.find<ThemeController>().darkTheme
                                    ? 700
                                    : 300]),
                        SizedBox(height: 5),
                        Container(
                            height: 10,
                            width: 130,
                            color: Colors.grey[
                                Get.find<ThemeController>().darkTheme
                                    ? 700
                                    : 300]),
                        SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 10,
                                  width: 30,
                                  color: Colors.grey[
                                      Get.find<ThemeController>().darkTheme
                                          ? 700
                                          : 300]),
                              RatingBar(rating: 0.0, size: 12, ratingCount: 0),
                            ]),
                      ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
