class ZoneResponseModel {
  bool? _isSuccess;
  List<int>? _zoneIds;
  String? _message;
  List<ZoneData>? _zoneData;
  ZoneResponseModel(this._isSuccess, this._message, this._zoneIds, this._zoneData);

  String? get message => _message;
  List<int>? get zoneIds => _zoneIds;
  bool? get isSuccess => _isSuccess;
  List<ZoneData>? get zoneData => _zoneData;
}

class ZoneData {
  int? id;
  int? status;
  double? minimumShippingCharge;
  double? perKmShippingCharge;
  bool? cashOnDelivery;
  bool? digitalPayment;

  ZoneData(
      {this.id,
        this.status,
        this.cashOnDelivery,
        this.digitalPayment,
        this.minimumShippingCharge,
        this.perKmShippingCharge});

  ZoneData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    cashOnDelivery = json['cash_on_delivery'];
    digitalPayment = json['digital_payment'];
    minimumShippingCharge = json['minimum_shipping_charge'] != null ? json['minimum_shipping_charge'].toDouble() : null;
    perKmShippingCharge = json['per_km_shipping_charge'] != null ? json['per_km_shipping_charge'].toDouble() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['cash_on_delivery'] = this.cashOnDelivery;
    data['digital_payment'] = this.digitalPayment;
    data['minimum_shipping_charge'] = this.minimumShippingCharge;
    data['per_km_shipping_charge'] = this.perKmShippingCharge;
    return data;
  }
}

