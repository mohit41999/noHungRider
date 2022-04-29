import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rider_app/model/BeanAcceptOrder.dart';
import 'package:rider_app/model/BeanGetOrder.dart';
import 'package:rider_app/model/BeanrejectOrder.dart';
import 'package:rider_app/network/ApiProvider.dart';
import 'package:rider_app/screen/MyDrawer.dart';
import 'package:rider_app/screen/OrderScreen.dart';
import 'package:rider_app/utils/Constents.dart';
import 'package:rider_app/utils/HttpException.dart';
import 'package:rider_app/utils/Utils.dart';
import 'package:rider_app/utils/progress_dialog.dart';

import '../res.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();

  Future _future;

  var expected_earning = "";
  var trip_distance = "";

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  ProgressDialog progressDialog;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _future = getOrders(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff7ED39C), Color(0xff089E90)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 1],
                    ),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          child: Text(
                            "Hello!",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          padding: EdgeInsets.only(left: 16, top: 46),
                        ),
                      ),
                      Center(
                        child: Padding(
                          child: Text(
                            "You have 2 new order",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: AppConstant.fontBold),
                          ),
                          padding: EdgeInsets.only(left: 16, top: 20),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CircularPercentIndicator(
                        radius: 180.0,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 8.0,
                        percent: 0.8,
                        center: Container(
                            width: 155,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14)),
                            height: 155,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Stack(
                                  children: [
                                    GoogleMap(
                                      zoomControlsEnabled: false,
                                      onMapCreated: _onMapCreated,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(26.9124, 75.7873),
                                        zoom: 11.0,
                                      ),
                                      mapType: MapType.normal,
                                    ),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 80),
                                        alignment: Alignment.bottomCenter,
                                        width: 60,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Center(
                                          child: Text(
                                            "00:01",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ))),
                        circularStrokeCap: CircularStrokeCap.butt,
                        backgroundColor: Color(0xff21AB66),
                        progressColor: Color(0xffD0F753),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            children: [
                              Padding(
                                child: Text(
                                  AppConstant.rupee + expected_earning,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: AppConstant.fontBold),
                                ),
                                padding: EdgeInsets.only(top: 5, left: 6),
                              ),
                              Padding(
                                child: Text(
                                  "Expected Earning",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                padding: EdgeInsets.only(top: 6),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              color: Colors.white,
                              width: 1,
                              height: 30,
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                child: Text(
                                  trip_distance + "km",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: AppConstant.fontBold),
                                ),
                                padding: EdgeInsets.only(left: 20, top: 5),
                              ),
                              Padding(
                                child: Text(
                                  "Trip Distance",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                padding: EdgeInsets.only(left: 20, top: 1),
                              ),
                            ],
                          )
                        ],
                      ),
                      Expanded(
                        child: FutureBuilder<BeanGetOrder>(
                            future: _future,
                            builder: (context, projectSnap) {
                              print(projectSnap);
                              if (projectSnap.connectionState ==
                                  ConnectionState.done) {
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
                                        return getUserList(result[index]);
                                      },
                                      itemCount: result.length,
                                    );
                                  }
                                }
                              }
                              return Container(
                                  child: Center(
                                child: Text(
                                  "No Order Available",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ));
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget getUserList(Data result) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  OrderScreen(result.orderid, result.orderitems_id)),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppConstant.lightGreen)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, top: 10),
                  child: Image.asset(
                    Res.ic_circle_avatar,
                    width: 50,
                    height: 50,
                  ),
                ),
                Expanded(
                  child: Padding(
                    child: Text(
                      result.kitchenname,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: AppConstant.fontBold),
                    ),
                    padding: EdgeInsets.only(left: 16),
                  ),
                ),
                InkWell(
                  onTap: () {
                    acceptOrder(result.orderid, result.orderitems_id);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 10, right: 16),
                    child: Image.asset(
                      Res.ic_check,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    rejectOrder(result.orderid, result.orderitems_id);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 1, top: 10, right: 16),
                    child: Image.asset(
                      Res.ic_cross,
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 75, bottom: 6),
                    child: Image.asset(
                      Res.ic_time,
                      width: 15,
                      height: 15,
                    )),
                Padding(
                  child: Text(
                    result.picktime,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppConstant.fontBold),
                  ),
                  padding: EdgeInsets.only(left: 5, bottom: 6),
                ),
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 10),
                  child: Image.asset(
                    Res.ic_location,
                    width: 20,
                    height: 20,
                  ),
                ),
                Container(
                  width: 190,
                  margin: EdgeInsets.only(bottom: 10),
                  child: Padding(
                    child: Text(
                      result.deliveryaddress,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: AppConstant.fontBold),
                    ),
                    padding: EdgeInsets.only(left: 5),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<BeanGetOrder> getOrders(BuildContext context) async {
    progressDialog.show();
    try {
      var user = await Utils.getUser();
      FormData from =
          FormData.fromMap({"userid": user.data.userId, "token": "123456789"});
      BeanGetOrder bean = await ApiProvider().getOrder(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        setState(() {
          Utils.showToast(bean.message);
          expected_earning = bean.global.expectedEarnings.toString();
          trip_distance = bean.global.tripDistance.toString();
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

  Future<BeanRejectOrder> rejectOrder(
      String orderid, String orderitems_id) async {
    progressDialog.show();
    try {
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data.userId,
        "token": "123456789",
        "orderid": orderid,
        'orderitems_id': orderitems_id
      });
      BeanRejectOrder bean = await ApiProvider().rejectOrder(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);
        setState(() {
          _future = getOrders(context);
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

  Future<BeanAcceptOrder> acceptOrder(
      String orderid, String orderitems_id) async {
    progressDialog.show();
    try {
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data.userId,
        "token": "123456789",
        "orderid": orderid,
        "orderitems_id": orderitems_id
      });
      BeanAcceptOrder bean = await ApiProvider().acceptOrder(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => OrderScreen(orderid, orderitems_id)),
        ).then((value) {
          setState(() {
            _future = getOrders(context);
          });
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
