class BeanGetOrder {
  bool status;
  String message;
  Global global;
  List<Data> data;

  BeanGetOrder({this.status, this.message, this.global, this.data});

  BeanGetOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    global =
    json['global'] != null ? new Global.fromJson(json['global']) : null;
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
    if (this.global != null) {
      data['global'] = this.global.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Global {
  int tripDistance;
  int expectedEarnings;

  Global({this.tripDistance, this.expectedEarnings});

  Global.fromJson(Map<String, dynamic> json) {
    tripDistance = json['trip_distance'];
    expectedEarnings = json['expected_earnings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trip_distance'] = this.tripDistance;
    data['expected_earnings'] = this.expectedEarnings;
    return data;
  }
}

class Data {
  String orderid;
  String kitchenname;
  String picktime;
  String deliveryaddress;
  String status;

  Data(
      {this.orderid,
        this.kitchenname,
        this.picktime,
        this.deliveryaddress,
        this.status});

  Data.fromJson(Map<String, dynamic> json) {
    orderid = json['orderid'];
    kitchenname = json['kitchenname'];
    picktime = json['picktime'];
    deliveryaddress = json['deliveryaddress'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderid'] = this.orderid;
    data['kitchenname'] = this.kitchenname;
    data['picktime'] = this.picktime;
    data['deliveryaddress'] = this.deliveryaddress;
    data['status'] = this.status;
    return data;
  }
}