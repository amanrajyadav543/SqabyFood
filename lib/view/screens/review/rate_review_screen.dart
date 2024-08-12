import 'package:sqabyfood_sqaby/controller/product_controller.dart';
import 'package:sqabyfood_sqaby/data/model/response/order_details_model.dart';
import 'package:sqabyfood_sqaby/data/model/response/order_model.dart';
import 'package:sqabyfood_sqaby/util/dimensions.dart';
import 'package:sqabyfood_sqaby/util/styles.dart';
import 'package:sqabyfood_sqaby/view/base/custom_app_bar.dart';
import 'package:sqabyfood_sqaby/view/screens/review/widget/deliver_man_review_widget.dart';
import 'package:sqabyfood_sqaby/view/screens/review/widget/product_review_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/response/submit_review_delivery_model.dart';
import '../../../data/model/response/submit_review_model.dart';

class RateReviewScreen extends StatefulWidget {
  final List<OrderDetailsModel> orderDetailsList;
  final List<SubmitReviewModel>? submitreviewlist;
  final DeliveryMan? deliveryMan;
  final int orderID;
  final SubmitDeliveryReviewModel? submitDeliveryReviewModel;
  RateReviewScreen(
      {required this.orderDetailsList, required this.deliveryMan,required this.orderID,this.
      submitreviewlist, this.submitDeliveryReviewModel});

  @override
  _RateReviewScreenState createState() => _RateReviewScreenState();
}

class _RateReviewScreenState extends State<RateReviewScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: (widget.deliveryMan == null || widget.orderDetailsList.length == 0) ? 1 : 2, initialIndex: 0, vsync: this);

    Get.find<ProductController>().initRatingData(widget.orderDetailsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: 'rate_review'.tr),
      body: Column(children: [
        Center(
          child: Container(
            width: Dimensions.WEB_MAX_WIDTH,
            color: Theme.of(context).cardColor,
            child: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).textTheme.bodyText1!.color,
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              unselectedLabelStyle: robotoRegular.copyWith(
                  color: Theme.of(context).disabledColor,
                  fontSize: Dimensions.fontSizeSmall),
              labelStyle:
                  robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
              tabs: widget.orderDetailsList.length > 0 ? widget.deliveryMan != null ? [
                Tab(text: widget.orderDetailsList.length > 1 ? 'items'.tr : 'item'.tr),
                Tab(text: 'delivery_man'.tr),
              ] : [
                Tab(text: widget.orderDetailsList.length > 1 ? 'items'.tr : 'item'.tr),
              ] : [
                Tab(text: 'delivery_man'.tr),
              ],
            ),
          ),
        ),
        Expanded(child: TabBarView(
          controller: _tabController,
          children: widget.orderDetailsList.length > 0 ? widget.deliveryMan != null ? [
            ProductReviewWidget(orderDetailsList: widget.orderDetailsList,submitreviewlist: widget.submitreviewlist,),
            DeliveryManReviewWidget(deliveryMan: widget.deliveryMan, orderID: widget.orderID.toString(),submitDeliveryReviewModel: widget.submitDeliveryReviewModel,),
          ] : [
            ProductReviewWidget(orderDetailsList: widget.orderDetailsList,submitreviewlist: widget.submitreviewlist),
          ] : [
            DeliveryManReviewWidget(deliveryMan: widget.deliveryMan, orderID: widget.orderID.toString(),submitDeliveryReviewModel: widget.submitDeliveryReviewModel,),
          ],
        )),
      ]),
    );
  }
}
