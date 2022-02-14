class GetChat {
  bool status;
  String message;
  List<Data> data;

  GetChat({this.status, this.message, this.data});

  GetChat.fromJson(Map<String, dynamic> json) {
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
  String createddate;
  String time;
  String msgType;
  String message;

  Data({this.createddate, this.time, this.msgType, this.message});

  Data.fromJson(Map<String, dynamic> json) {
    createddate = json['createddate'];
    time = json['time'];
    msgType = json['msg_type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createddate'] = this.createddate;
    data['time'] = this.time;
    data['msg_type'] = this.msgType;
    data['message'] = this.message;
    return data;
  }
}