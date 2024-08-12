import 'package:sqabyfood_sqaby/controller/campaign_controller.dart';
import 'package:sqabyfood_sqaby/util/dimensions.dart';
import 'package:sqabyfood_sqaby/view/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemCampaignScreen extends StatefulWidget {
  @override
  State<ItemCampaignScreen> createState() => _ItemCampaignScreenState();
}

class _ItemCampaignScreenState extends State<ItemCampaignScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CampaignController>().getItemCampaignList(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'campaigns'.tr),
      body: Scrollbar(
          child: SingleChildScrollView(
              child: Center(
                  child: SizedBox(
        width: Dimensions.WEB_MAX_WIDTH,
        child: GetBuilder<CampaignController>(builder: (campController) {
          return Padding(padding: EdgeInsets.all(10));
          // return ProductView(
          //   isRestaurant: false,
          //   products: campController.itemCampaignList,
          //   restaurants: null,
          //   isCampaign: true,
          //   noDataText: 'no_campaign_found'.tr,
          // );
        }),
      )))),
    );
  }
}
