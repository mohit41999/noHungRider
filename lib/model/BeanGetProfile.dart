class GetProfile {
  bool status;
  String message;
  List<Data> data;

  GetProfile({this.status, this.message, this.data});

  GetProfile.fromJson(Map<String, dynamic> json) {
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
  String username;
  int avgRattings;
  String mobilenumber;
  String address;
  String totalEarning;

  Data(
      {this.username,
        this.avgRattings,
        this.mobilenumber,
        this.address,
        this.totalEarning});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    avgRattings = json['avg_rattings'];
    mobilenumber = json['mobilenumber'];
    address = json['address'];
    totalEarning = json['total_earning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['avg_rattings'] = this.avgRattings;
    data['mobilenumber'] = this.mobilenumber;
    data['address'] = this.address;
    data['total_earning'] = this.totalEarning;
    return data;
  }
}