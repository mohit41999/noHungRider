class GetOrderDetails {
  bool status;
  String message;
  List<Data> data;

  GetOrderDetails({this.status, this.message, this.data});

  GetOrderDetails.fromJson(Map<String, dynamic> json) {
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
  String orderid;
  String pickby;
  String status;
  String kitchenname;
  String kitchenAddress;
  String kitchencontactnumber;
  String customername;
  String deliveryaddress;
  String itemDetails;

  Data(
      {this.orderid,
        this.pickby,
        this.status,
        this.kitchenname,
        this.kitchenAddress,
        this.kitchencontactnumber,
        this.customername,
        this.deliveryaddress,
        this.itemDetails});

  Data.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    pickby = json['pickby'];
    status = json['status'];
    kitchenname = json['kitchenname'];
    kitchenAddress = json['kitchen_address'];
    kitchencontactnumber = json['kitchencontactnumber'];
    customername = json['customername'];
    deliveryaddress = json['deliveryaddress'];
    itemDetails = json['item_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    data['pickby'] = this.pickby;
    data['status'] = this.status;
    data['kitchenname'] = this.kitchenname;
    data['kitchen_address'] = this.kitchenAddress;
    data['kitchencontactnumber'] = this.kitchencontactnumber;
    data['customername'] = this.customername;
    data['deliveryaddress'] = this.deliveryaddress;
    data['item_details'] = this.itemDetails;
    return data;
  }
}