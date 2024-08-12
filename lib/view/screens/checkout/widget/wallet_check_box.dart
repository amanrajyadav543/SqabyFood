import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqabyfood_sqaby/controller/order_controller.dart';

import '../../../../util/styles.dart';

class WalletPaymentBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Row(
              children: [
                Checkbox(
                  activeColor: Theme.of(context).primaryColor,
                  value: Get.find<OrderController>().box,
                  onChanged: (bool? value) =>
                      Get.find<OrderController>().walletPayment(),
                ),
                Text('Wallet'.tr, style: robotoRegular),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
