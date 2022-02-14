import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:rider_app/model/BeanSendMessage.dart' as Chat;
import 'package:rider_app/model/GetChat.dart' as response;
import 'package:rider_app/model/GetChat.dart';
import 'package:rider_app/network/ApiProvider.dart';
import 'package:rider_app/utils/Constents.dart';
import 'package:rider_app/utils/HttpException.dart';
import 'package:rider_app/utils/Utils.dart';
import 'package:rider_app/utils/progress_dialog.dart';

import '../res.dart';

class CutomerChatScreen extends StatefulWidget {
  @override
  _CutomerChatScreenState createState() => _CutomerChatScreenState();
}

class _CutomerChatScreenState extends State<CutomerChatScreen> {
  var type = "";
  Future future;
  ScrollController scrollController = ScrollController();

  List<response.Data> list;
  Future<List<response.Data>> _future;
  var _msg = TextEditingController();

  ProgressDialog progressDialog;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      _future = getChat(context);
    });
    super.initState();
  }

/*
  Future<List<Chat.Result>> getChat(BuildContext context) async {
    var user = await Utils.getUser();
    userID = user.result[0].userId;
    FormData data = FormData.fromMap({
      "user_id": userID,
      "fri_id": bean.tutorId
    });
    GetMsg getMsg = await ApiProvider.baseUrl().getMsg(data);
    list = getMsg.result;
    if(list==null){
      list = List();
    }
    return list;

  }*/

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: AppConstant.lightGreen,
                    margin: EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        InkWell(
                            onTap: () {},
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Image.asset(
                                  Res.ic_back,
                                  width: 30,
                                  height: 30,
                                  color: Colors.white,
                                ),
                              ),
                            )),
                        SizedBox(
                          width: 16,
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Image.asset(
                              Res.ic_user,
                              width: 50,
                              height: 50,
                            )),
                        Padding(
                          child: Text(
                            "Admin",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppConstant.fontBold,
                                fontSize: 20),
                          ),
                          padding: EdgeInsets.only(top: 20, left: 16),
                        )
                      ],
                    ),
                    height: 100,
                  ),
                  Expanded(
                      child: FutureBuilder<List<response.Data>>(
                    future: _future,
                    builder: (context, projectSnap) {
                      print(projectSnap);
                      if (projectSnap.connectionState == ConnectionState.done) {
                        if (projectSnap.hasData) {
                          return ListView.builder(
                            itemCount: list.length,
                            controller: scrollController,
                            itemBuilder: (context, index) {
                              return chatDesign(list[index]);
                            },
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  )),
                  /* Expanded(
                      child: FutureBuilder<List<response.Data>>(
                        future: _future,
                        builder: (context, projectSnap) {
                          print(projectSnap);
                          if (projectSnap.connectionState ==
                              ConnectionState.done) {
                            if (projectSnap.hasData) {
                              return ListView.builder(
                                itemCount: list.length,
                                controller: scrollController,
                                itemBuilder: (context, index) {
                                  return chatDesign(list[index]);
                                },
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                        },
                      )),*/
                  /*   Expanded(
                      child: FutureBuilder<List<response.Data>>(
                        future: _future,
                        builder: (context, projectSnap) {
                          print(projectSnap);
                          if (projectSnap.connectionState == ConnectionState.done) {
                            if (projectSnap.hasData) {
                              return ListView.builder(
                                itemCount: list.length,
                                controller: scrollController,
                                itemBuilder: (context, index) {
                                  return chatDesign(list[index]);
                                },
                              );
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        },
                      )),*/
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 50,
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    decoration: BoxDecoration(
                        color: Color(0xffF3F6FA),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: TextField(
                              controller: _msg,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Write message"),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            validation();
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: 16, bottom: 16, top: 8),
                            child: Image.asset(
                              Res.ic_send,
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ));
  }

  Future<List<response.Data>> getChat(BuildContext context) async {
    progressDialog.show();

    FormData from = FormData.fromMap({"userid": "70", "token": "123456789"});
    GetChat bean = await ApiProvider().getChat(from);
    progressDialog.dismiss();
    list = bean.data;
    if (bean.status == true) {
      if (list == null) {
        list = List();
      }
      setState(() {});

      return list;
    }
  }
  /*Future<List<response.Data>> getChat(BuildContext context) async {
    progressDialog.show();
    try {
      FormData from = FormData.fromMap({"userid": "70", "token": "123456789"});
      GetChat bean = await ApiProvider().getChat(from);
      list=bean.data;
      print(bean.data);
      progressDialog.dismiss();
      if (bean.status == true) {
        if(list==null){
          list=List();
        }
        setState(() {


        });

        return list;
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
  }*/

  chatDesign(response.Data result) {
    if (result.msgType == "sent") {
      return Container(
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    width: 100,
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 16, bottom: 16),
                    decoration: BoxDecoration(
                        color: Color(0xffBEE8FF),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16, top: 16, right: 16, bottom: 16),
                            child: Text(
                              result.message,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ));
    } else if (result.msgType == "received") {
      return Container(
          margin: EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    width: 100,
                    margin: EdgeInsets.only(
                        left: 20, right: 20, top: 16, bottom: 16),
                    decoration: BoxDecoration(
                        color: Color(0xffF3F6FA),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 16, top: 16, right: 16, bottom: 16),
                            child: Text(
                              result.message,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ));
    }
  }

  Future<Chat.BeanSendMessage> sendMessage(String messageInput) async {
    try {
      var user = await Utils.getUser();
      FormData from = FormData.fromMap({
        "userid": user.data.userId,
        "token": "123456789",
        "message": messageInput,
      });
      Chat.BeanSendMessage bean = await ApiProvider().sendMessage(from);
      print(bean.data);
      if (bean.status == true) {
        messageInput = _msg.text = "";
        response.Data result = response.Data();
        result.message = bean.data.message;
        result.msgType = bean.data.msgType;
        result.createddate = bean.data.createddate;
        if (list != null) {
          list.add(result);
        } else {
          list = List();
          list.add(result);
        }
        setState(() {
          messageInput = _msg.text = "";
        });

        Future.delayed(const Duration(milliseconds: 500), () {
          scrollController.animateTo(scrollController.position.maxScrollExtent,
              curve: Curves.ease, duration: Duration(milliseconds: 300));
        });
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

  void validation() {
    var messageInput = _msg.text.toString();
    if (messageInput.isEmpty) {
      Utils.showToast("Please Enter Message");
    } else {
      sendMessage(messageInput);
    }
  }
}
