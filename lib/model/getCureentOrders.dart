// To parse this JSON data, do
//
//     final getCurrentOrdersModel = getCurrentOrdersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GetCurrentOrdersModel getCurrentOrdersModelFromJson(String str) =>
    GetCurrentOrdersModel.fromJson(json.decode(str));

String getCurrentOrdersModelToJson(GetCurrentOrdersModel data) =>
    json.encode(data.toJson());

class GetCurrentOrdersModel {
  bool status;
  String message;
  List<Data> data;

  GetCurrentOrdersModel({this.status, this.message, this.data});

  GetCurrentOrdersModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Data({
    @required this.orderId,
    @required this.orderitemsId,
    @required this.status,
    @required this.deliveryaddress,
  });

  final String orderId;
  final String orderitemsId;
  final String status;
  final String deliveryaddress;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orderId: json["order_id"],
        orderitemsId: json["orderitems_id"],
        status: json["status"],
        deliveryaddress: json["deliveryaddress"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "orderitems_id": orderitemsId,
        "status": status,
        "deliveryaddress": deliveryaddress,
      };
}
