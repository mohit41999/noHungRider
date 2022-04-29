import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:rider_app/model/BeanWithdrawpayment.dart';
import 'package:rider_app/model/GetOrdeHistory.dart';
import 'package:rider_app/network/ApiProvider.dart';
import 'package:rider_app/res.dart';
import 'package:rider_app/screen/FilterScreen.dart';
import 'package:rider_app/screen/MyDrawer.dart';
import 'package:rider_app/utils/HttpException.dart';
import 'package:rider_app/utils/Utils.dart';
import 'package:rider_app/utils/progress_dialog.dart';

import '../utils/Constents.dart';

class OrderHistoryscreen extends StatefulWidget {
  var startDate;
  var endDate;
  var status;
  var filter;
  OrderHistoryscreen(this.startDate, this.endDate, this.status, this.filter);

  @override
  _OrderHistoryscreenState createState() => _OrderHistoryscreenState();
}

class _OrderHistoryscreenState extends State<OrderHistoryscreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog;
  Future future;
  var expectedEarning = "";
  var currentOrder = "";
  var Cancelled = "";
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      future = getOrderHistory(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        key: _scaffoldKey,
        drawer: MyDrawers(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _scaffoldKey.currentState.openDrawer();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, top: 50),
                      child: Image.asset(
                        Res.ic_menu,
                        width: 30,
                        height: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 50),
                      child: Text(
                        "Order History",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      addFilter();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 50, right: 16),
                      child: Image.asset(
                        Res.ic_filter,
                        width: 30,
                        height: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 180,
                  child: Center(
                    child: Image.asset(
                      Res.ic_default_oder,
                    ),
                  )),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "Expected Earning",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      "Current Orders",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: Text(
                      currentOrder,
                      style: TextStyle(
                          color: AppConstant.appColor,
                          fontSize: 14,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        AppConstant.rupee + expectedEarning,
                        style: TextStyle(
                            color: AppConstant.lightGreen,
                            fontSize: 22,
                            fontFamily: AppConstant.fontRegular),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16),
                    child: Text(
                      "Cancelled",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: Text(
                      Cancelled,
                      style: TextStyle(
                          color: AppConstant.appColor,
                          fontSize: 14,
                          fontFamily: AppConstant.fontRegular),
                    ),
                  ),
                ],
              ),

              /*Center(
                child: Container(
                  margin: EdgeInsets.only(right: 16,top: 16),
                  height: 50,
                  width: 160,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text("+ Add Account Details",style: TextStyle(color: Colors.white,fontSize: 13,fontFamily: AppConstant.fontBold),),
                  ),
                ),
              ),*/
              SizedBox(
                height: 16,
              ),
              Divider(
                color: Colors.grey,
              ),
              FutureBuilder<GetOrderHistory>(
                  future: future,
                  builder: (context, projectSnap) {
                    print(projectSnap);
                    if (projectSnap.connectionState == ConnectionState.done) {
                      var result;
                      if (projectSnap.data != null) {
                        result = projectSnap.data.data;
                        if (result != null) {
                          print(result.length);
                          return ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return getItem(result[index]);
                            },
                            itemCount: result.length,
                          );
                        }
                      }
                    }
                    return Container(
                        child: Center(
                      child: Text(
                        "No Order History",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ));
                  }),
              GestureDetector(
                onTap: () {
                  // withdrawPayment();
                },
                child: Container(
                  margin:
                      EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff7ED39C),
                        Color(0xff7ED39C),
                        Color(0xff7ED39C),
                        Color(0xff089E90)
                      ],
                      begin: Alignment.bottomLeft,
                      stops: [0, 0, 0, 1],
                    ),
                  ),
                  child: Center(
                    child: Center(
                      child: Text(
                        "WITHDRAW PAYMENT",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppConstant.fontBold,
                            fontSize: 10),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          physics: BouncingScrollPhysics(),
        ));
  }

  Widget getItem(Data result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16, top: 16),
                child: Text(
                  result.time,
                  style: TextStyle(
                      color: Colors.black, fontFamily: AppConstant.fontRegular),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 30,
                width: 70,
                margin: EdgeInsets.only(left: 40, top: 16, right: 40),
                decoration: BoxDecoration(
                    color: Color(0xff7ED39C),
                    borderRadius: BorderRadius.circular(3)),
                child: Center(
                    child: Text(
                  result.status,
                  style: TextStyle(color: Colors.black, fontSize: 10),
                )),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Text(
                    AppConstant.rupee + result.deliverycharge,
                    style: TextStyle(
                        color: Colors.black, fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 5, right: 16),
                  child: Text(
                    result.date,
                    style: TextStyle(
                        color: Colors.grey, fontFamily: AppConstant.fontBold),
                  ),
                ),
              ],
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "Order By" + result.orderBy,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        Divider(
          color: Colors.grey.shade400,
        ),
      ],
    );
  }

  Future<BeanWithdrawpayment> withdrawPayment() async {
    progressDialog.show();
    try {
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data.userId.toString(),
        "token": "123456789",
        "amount": "70"
      });
      BeanWithdrawpayment bean = await ApiProvider().acceptOrder(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);
        setState(() {});

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  Future<GetOrderHistory> getOrderHistory(BuildContext context) async {
    progressDialog.show();
    try {
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data.userId,
        "token": "123456789",
        "date_from": widget.startDate,
        "date_to": widget.endDate,
        "status": widget.status,
      });

      print("newstatussss" +
          widget.startDate.toString() +
          widget.endDate.toString() +
          widget.status.toString());
      GetOrderHistory bean = await ApiProvider().getOrderHistory(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);
        setState(() {
          Cancelled = bean.global.cancelled;
          expectedEarning = bean.global.expectedEarnings.toString();
          currentOrder = bean.global.currentOrders.toString();
        });

        return bean;
      } else {
        Utils.showToast(bean.message);
      }

      return null;
    } on HttpException catch (exception) {
      progressDialog.dismiss();
      print(exception);
    } catch (exception) {
      progressDialog.dismiss();
      print(exception);
    }
  }

  addFilter() async {
    var resultCardData = await Navigator.push(
        context, MaterialPageRoute(builder: (_) => FilterScreen()));

    if (widget.filter == "filter") {
      future = getOrderHistory(context);
    }
  }
}
