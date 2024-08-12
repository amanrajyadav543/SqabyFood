import 'package:sqabyfood_sqaby/data/model/response/product_model.dart';
import 'package:sqabyfood_sqaby/data/model/response/restaurant_model.dart';

class CampaignModel {
  int? id;
  String? title;
  String? image;
  String? description;
  String? availableDateStarts;
  String? availableDateEnds;
  String? startTime;
  String? endTime;
  int? restaurantid;
  int? foodid;
  Product? product;
  Restaurant? restaurant;
  CampaignModel(
      {this.id,
        this.title,
        this.image,
        this.description,
        this.availableDateStarts,
        this.availableDateEnds,
        this.startTime,
        this.endTime,
        this.restaurantid,
        this.foodid,
        this.product,
        this.restaurant,
       });

  CampaignModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    availableDateStarts = json['available_date_starts'];
    availableDateEnds = json['available_date_ends'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    restaurantid = json['restaurant_id'];
    foodid = json['food_id'];
    product = json['product'] != null
        ? new Product.fromJson(json['product'])
        : null;
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['description'] = this.description;
    data['available_date_starts'] = this.availableDateStarts;
    data['available_date_ends'] = this.availableDateEnds;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['restaurant_id'] = this.restaurantid;
    data['food_id'] = this.foodid;
    if (this.product != null) {
      data['product'] = this.product?.toJson();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant?.toJson();
    }
    return data;
  }
}
