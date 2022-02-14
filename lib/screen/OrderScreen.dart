import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:rider_app/model/GetOrderDetails.dart';
import 'package:rider_app/network/ApiProvider.dart';
import 'package:rider_app/res.dart';
import 'package:rider_app/screen/MyDrawer.dart';
import 'package:rider_app/screen/StartDeliveryScreen.dart';
import 'package:rider_app/utils/Constents.dart';
import 'package:rider_app/utils/HttpException.dart';
import 'package:rider_app/utils/Utils.dart';
import 'package:rider_app/utils/progress_dialog.dart';

class OrderScreen extends StatefulWidget {
  var orderID;
  OrderScreen(this.orderID);

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  var isSelected = 1;
  var pickupBy = "";
  var kitchename = "";
  var loction = "";
  var name = "";
  var deliveryAddress = "";
  var itemDetails = "";
  var status = "";

  ProgressDialog progressDialog;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Future future;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      future = getOrderDetails(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        drawer: MyDrawers(),
        key: _scaffoldKey,
        backgroundColor: AppConstant.lightGreen,
        body: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(top: 230),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(38),
                        topLeft: Radius.circular(38))),
                height: double.infinity,
                child: method()),
            Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _scaffoldKey.currentState.openDrawer();
                          });
                        },
                        child: Image.asset(
                          Res.ic_menu,
                          width: 30,
                          height: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(
                            "New Orders",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppConstant.fontBold,
                                fontSize: 16),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: Image.asset(
                          Res.ic_noti,
                          width: 25,
                          height: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  height: 150,
                ),
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white)),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                isSelected = 1;
                                print(isSelected);
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: isSelected == 1
                                      ? Color(0xffD0F753)
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(100),
                                      bottomLeft: Radius.circular(100))),
                              child: Center(
                                child: Text(
                                  "Order1",
                                  style: TextStyle(
                                      color: isSelected == 1
                                          ? Colors.black
                                          : Colors.black,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                            )),
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                isSelected = 2;
                                print(isSelected);
                              });
                            },
                            child: Container(
                              height: 60,
                              width: 180,
                              decoration: BoxDecoration(
                                  color: isSelected == 2
                                      ? Color(0xffD0F753)
                                      : Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(100),
                                      bottomRight: Radius.circular(100))),
                              child: Center(
                                child: Text(
                                  "Order2",
                                  style: TextStyle(
                                      color: isSelected == 2
                                          ? Colors.black
                                          : Colors.black,
                                      fontFamily: AppConstant.fontBold),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }

  method() {
    if (isSelected == 1) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "Pickup By",
                        style: TextStyle(
                            color: AppConstant.appColor, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        pickupBy,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 16, top: 10),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "Order Status",
                        style: TextStyle(
                            color: AppConstant.appColor, fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      width: 140,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          status,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppConstant.fontRegular,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Image.asset(
                          Res.ic_chef,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Image.asset(
                        Res.ic_circle_avatar,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          child: Text(
                            kitchename,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Image.asset(
                                Res.ic_location,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Padding(
                              child: Text(
                                loction,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: AppConstant.fontBold),
                              ),
                              padding: EdgeInsets.only(left: 5, right: 16),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 1),
                              child: Image.asset(
                                Res.ic_call,
                                width: 30,
                                height: 30,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 16, top: 10),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Delivery Address",
                    style: TextStyle(
                        color: AppConstant.appColor,
                        fontSize: 14,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    name.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Image.asset(
                        Res.ic_location,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Container(
                      width: 180,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          deliveryAddress,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Item Details",
                    style: TextStyle(
                        color: Color(0xffA7A8BC),
                        fontSize: 14,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Image.asset(
                        Res.ic_dinner,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        itemDetails,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartDeliveryScreen(
                                deliveryAddress, widget.orderID)),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 16, top: 36, bottom: 16, right: 16),
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(13)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "Start Delivery",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 14),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 36),
                              child: Image.asset(
                                Res.ic_right_arrow,
                                width: 20,
                                height: 20,
                                color: Color(0xffD0F753),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
        physics: BouncingScrollPhysics(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "Pickup By",
                        style: TextStyle(
                            color: AppConstant.appColor, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        pickupBy,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 16, top: 10),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        "Order Status",
                        style: TextStyle(
                            color: AppConstant.appColor, fontSize: 14),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      width: 140,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          status,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppConstant.fontRegular,
                              fontSize: 14),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 16),
                        child: Image.asset(
                          Res.ic_chef,
                          width: 100,
                          height: 100,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Image.asset(
                        Res.ic_circle_avatar,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          child: Text(
                            kitchename,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: AppConstant.fontBold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Image.asset(
                                Res.ic_location,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            Padding(
                              child: Text(
                                loction,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontFamily: AppConstant.fontBold),
                              ),
                              padding: EdgeInsets.only(left: 5, right: 16),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 1),
                              child: Image.asset(
                                Res.ic_call,
                                width: 30,
                                height: 30,
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 16, top: 10),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Delivery Address",
                    style: TextStyle(
                        color: AppConstant.appColor,
                        fontSize: 14,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    name.toString(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Image.asset(
                        Res.ic_location,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Container(
                      width: 180,
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, top: 16),
                        child: Text(
                          deliveryAddress,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: AppConstant.fontBold),
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Item Details",
                    style: TextStyle(
                        color: Color(0xffA7A8BC),
                        fontSize: 14,
                        fontFamily: AppConstant.fontBold),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Image.asset(
                        Res.ic_dinner,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        itemDetails,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: AppConstant.fontBold),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StartDeliveryScreen(
                                deliveryAddress, widget.orderID)),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 16, top: 36, bottom: 16, right: 16),
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(13)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(left: 50),
                                child: Text(
                                  "Start Delivery",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 14),
                                )),
                            Padding(
                              padding: EdgeInsets.only(left: 10, right: 36),
                              child: Image.asset(
                                Res.ic_right_arrow,
                                width: 20,
                                height: 20,
                                color: Color(0xffD0F753),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
        physics: BouncingScrollPhysics(),
      );
    }
  }

  Future<GetOrderDetails> getOrderDetails(BuildContext context) async {
    progressDialog.show();
    try {
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data.userId,
        "token": "123456789",
        "orderid": widget.orderID.toString()
      });
      print("orderIddd" + widget.orderID);
      GetOrderDetails bean = await ApiProvider().getOrderDetails(from);
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        Utils.showToast(bean.message);
        setState(() {
          if (bean.data != null) {
            pickupBy = bean.data[0].pickby;
            kitchename = bean.data[0].kitchenname;
            loction = bean.data[0].kitchenAddress;
            name = bean.data[0].customername;
            deliveryAddress = bean.data[0].deliveryaddress;
            if (bean.data[0].itemDetails != null) {
              itemDetails = bean.data[0].itemDetails;
            }

            status = bean.data[0].status;
          }
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
