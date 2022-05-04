import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:rider_app/model/BeanTripSummary.dart';
import 'package:rider_app/network/ApiProvider.dart';
import 'package:rider_app/screen/HomeScreen.dart';
import 'package:rider_app/utils/Constents.dart';
import 'package:rider_app/utils/HttpException.dart';
import 'package:rider_app/utils/Utils.dart';
import 'package:rider_app/utils/progress_dialog.dart';

import '../res.dart';

class TripSummaryScreen extends StatefulWidget {
  final String orderid;
  final String orderitems_id;

  const TripSummaryScreen(
      {Key key, @required this.orderid, @required this.orderitems_id})
      : super(key: key);
  @override
  TripSummaryScreenState createState() => TripSummaryScreenState();
}

class TripSummaryScreenState extends State<TripSummaryScreen> {
  Future future;

  var dilveryDuration = "";
  var trip_earning = "";
  var point_gained = "";
  var earnings_today = "";
  ProgressDialog progressDialog;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      future = getTripSummary(context, widget.orderid, widget.orderitems_id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false);
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.close,
                      color: Colors.transparent,
                    ),
                    Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text(
                              "Trip Summary",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: AppConstant.fontBold),
                            ))),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                        )),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16, top: 20),
                  child: Center(
                      child: Image.asset(
                    Res.ic_trip,
                    width: 150,
                    height: 150,
                  )),
                ),
                Center(
                    child: Text(
                  "You finished this order in" + " " + dilveryDuration,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
                Center(
                    child: Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          "Keep completing orders to earn more",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppConstant.lightGreen, fontSize: 16),
                        ))),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 20, left: 16),
                            child: Text(
                              "Trip Earning",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: AppConstant.fontRegular),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 20, left: 16),
                            child: Text(
                              AppConstant.rupee + trip_earning,
                              style: TextStyle(
                                  color: AppConstant.lightGreen,
                                  fontSize: 36,
                                  fontFamily: AppConstant.fontRegular),
                            )),
                      ],
                    )),
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 20, right: 16),
                            child: Text(
                              "Point gained",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: AppConstant.fontRegular),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 20, right: 16),
                            child: Text(
                              point_gained,
                              style: TextStyle(
                                  color: AppConstant.lightGreen,
                                  fontSize: 36,
                                  fontFamily: AppConstant.fontRegular),
                            ))
                      ],
                    )
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 20, right: 16),
                          child: Text(
                            "Earning Today",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: AppConstant.fontRegular),
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 20, right: 16),
                          child: Text(
                            AppConstant.rupee + earnings_today,
                            style: TextStyle(
                                color: AppConstant.lightGreen,
                                fontSize: 36,
                                fontFamily: AppConstant.fontRegular),
                          ))
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  Future<BeanTripSummary> getTripSummary(
      BuildContext context, String orderid, String orderitems_id) async {
    progressDialog.show();
    try {
      print(orderid + 'llllll');
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "token": "123456789",
        "userid": user.data.userId,
        "orderid": orderid,
        "orderitems_id": orderitems_id
      });
      BeanTripSummary bean = await ApiProvider().tripSummary(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          dilveryDuration = bean.data[0].deliveryDuration;
          trip_earning = bean.data[0].tripEarning;
          point_gained = bean.data[0].pointGained.toString();
          earnings_today = bean.data[0].earningsToday;
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
}
