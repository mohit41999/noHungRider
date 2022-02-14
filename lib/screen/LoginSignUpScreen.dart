import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

import 'package:image_picker/image_picker.dart';
import 'package:rider_app/model/BeanLogin.dart';
import 'package:rider_app/model/BeanSignUp.dart';
import 'package:rider_app/network/ApiProvider.dart';
import 'package:rider_app/utils/Constents.dart';
import 'package:rider_app/utils/PrefManager.dart';
import 'package:rider_app/utils/Utils.dart';
import 'package:rider_app/utils/progress_dialog.dart';

import '../res.dart';

class LoginSignUpScreen extends StatefulWidget {
  @override
  _LoginSignUpScreenState createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  var _Name = TextEditingController();
  var Contact_Number = TextEditingController();
  var City = TextEditingController();
  var LicenseNo = TextEditingController();
  var ExpiryDate = TextEditingController();
  var Email = TextEditingController();
  var PanCard = TextEditingController();
  var GstRegister = TextEditingController();
  final RiderId = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool selected = false;
  File _image;
  File _uploadimage;
  int _radioValue = -1;
  int _license = -1;
  var type = "";
  var menuFile = "";
  var document = "";
  ProgressDialog _progressDialog;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          setState(() {

          });
          break;

        case 1:
          setState(() {
          });
          break;
      }
    });
  }
  void _handleLicenseValueChange(int value) {
    setState(() {
      _license = value;
      switch (_license) {
        case 0:
          setState(() {

          });
          break;

        case 1:
          setState(() {
          });
          break;
      }
    });
  }
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _image = image;
    });
  }
  _uploadImgFromCamera() async {
    File uploadimage = await ImagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {

      _uploadimage = uploadimage;
    });
  }
  _uploadimgFromGallery() async {
    File uploadimage = await ImagePicker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _uploadimage = uploadimage;
    });
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      selected = !selected;
    });
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog=ProgressDialog(context);
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      body: Column(
        children: [
          new Container(
            height: 180,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/ic_bg_login.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 100,
            child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          child: Container(
                            child: TabBar(
                              unselectedLabelColor: Colors.grey,
                              labelColor: Colors.black,
                              indicatorColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.label,
                              isScrollable: true,
                              indicatorPadding: EdgeInsets.all(0),
                              controller: _controller,
                              labelStyle: TextStyle(fontWeight: FontWeight.bold),
                              tabs: [
                                Tab(child: Text("Login")),
                                Tab(child: Text("SignUp")),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                controller: _controller,
                children: <Widget>[
                  Stack(
                    children: [

                      SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                child: Text(
                                  "Welcome Back,",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontRegular),
                                ),
                                padding: EdgeInsets.only(left: 16, top: 20),
                              ),
                              Padding(
                                child: Text(
                                  "Rider",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold),
                                ),
                                padding: EdgeInsets.only(left: 16),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 16, top: 20, right: 16),
                                  child: TextFormField(
                                    controller: RiderId,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "Enter rider id",
                                      fillColor: Colors.grey,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                      ),
                                    ),
                                  )),
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, top: 16, bottom: 16),
                                child: TextField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.bottomLeft,
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, '/forgot');
                                          },
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                EdgeInsets.only(bottom: 16, left: 16),
                                                child: Text(
                                                  "Forgot password?",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily:
                                                      AppConstant.fontRegular),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: GestureDetector(
                                        onTap: ()=>{

                                          validationLogin()
                                        },
                                        child: Container(
                                          height: 55,
                                          width: 90,
                                          decoration: BoxDecoration(
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
                                              borderRadius: BorderRadius.circular(13)),
                                          margin:
                                          EdgeInsets.only(bottom: 16, right: 16),
                                          child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Center(
                                                child: Image.asset(Res.ic_right_arrow,
                                                    width: 20, height: 20),
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Container(
                      child: Stack(
                    children: [
                      SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                              child: Text(
                                "Enter you basic details here",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: AppConstant.fontBold),
                              ),
                              padding: EdgeInsets.only(left: 16, top: 10),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 20, right: 16),
                                child: TextFormField(
                                  controller: _Name,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                )),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: 16, right: 16, top: 16),
                              child: TextField(
                                controller: Contact_Number,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Contact Number",
                                  fillColor: Colors.grey,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 2.0),
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 20, right: 16),
                                child: TextFormField(
                                  controller: Email,
                                  decoration: InputDecoration(
                                    labelText: "Email ID",
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 20, right: 16),
                                child: TextFormField(
                                  controller: City,
                                  decoration: InputDecoration(
                                    labelText: "City",
                                    fillColor: Colors.grey,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                )),
                            Padding(
                              child: Text(
                                "What type of bike you have",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: AppConstant.fontRegular),
                              ),
                              padding: EdgeInsets.only(left: 16, top: 10),
                            ),
                            Row(
                              children: [
                                new Radio(
                                  value: 0,
                                  groupValue: _radioValue,
                                  activeColor: Color(0xff7EDABF),
                                  onChanged: _handleRadioValueChange,
                                ),
                                new Text(
                                  'Regular Bike',
                                  style: new TextStyle(fontSize:14,fontFamily: AppConstant.fontRegular),
                                ),

                                new Radio(
                                  value: 1,
                                  groupValue: _radioValue,
                                  activeColor: Color(0xff7EDABF),
                                  onChanged: _handleRadioValueChange,
                                ),
                                new Text(
                                  'E-Bike',
                                  style: new TextStyle(fontSize:14,fontFamily: AppConstant.fontRegular),
                                ),

                                new Radio(
                                  value: 2,
                                  groupValue: _radioValue,
                                  activeColor: Color(0xff7EDABF),
                                  onChanged: _handleRadioValueChange,
                                ),
                                new Text(
                                  'Bicycle',
                                  style: new TextStyle(fontSize:14,fontFamily: AppConstant.fontRegular),
                                ),
                              ],
                            ),
                            Padding(
                              child: Text(
                                "Do you have licence?",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontFamily: AppConstant.fontRegular),
                              ),
                              padding: EdgeInsets.only(left: 16, top: 10),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                new Radio(
                                  value: 0,
                                  groupValue: _license,
                                  activeColor: Color(0xff7EDABF),
                                  onChanged: _handleLicenseValueChange,
                                ),
                                new Text(
                                  'Yes',
                                  style: new TextStyle(fontSize:14,fontFamily: AppConstant.fontRegular),
                                ),

                                new Radio(
                                  value: 1,
                                  groupValue: _license,
                                  activeColor: Color(0xff7EDABF),
                                  onChanged: _handleLicenseValueChange,
                                ),
                                new Text(
                                  'No',
                                  style: new TextStyle(fontSize:14,fontFamily: AppConstant.fontRegular),
                                ),

                              ],
                            )


                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            validation();

                          /*  showDetailsVerifyDialog();*/
                          },
                          child: Container(
                            height: 55,
                            width: 90,
                            decoration: BoxDecoration(
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
                                borderRadius: BorderRadius.circular(13)),
                            margin: EdgeInsets.only(bottom: 16, right: 16),
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Center(
                                  child: Image.asset(Res.ic_right_arrow,
                                      width: 20, height: 20),
                                )),
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showDetailsVerifyDialog(String name, String phone, String emailid, String city) {
    showDialog(
        context: context,
        builder: (_) => Center(
                // Aligns the container to center
                child: GestureDetector(
              onTap: () {},
              child: Wrap(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ), // A simplified version of dialog.
                      width: 270.0,
                      height: 280.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              Res.ic_verify,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 20, right: 16),
                                child: Text(
                                  "Details verified",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.black,
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 18),
                                )),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 16, top: 20, right: 16),
                                child: Text(
                                  "You will get a call from NOHUNG",
                                  style: TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Colors.grey,
                                      fontFamily: AppConstant.fontRegular,
                                      fontSize: 12),
                                )),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {

                                 Navigator.pop(context);
                                signUp(name,emailid,phone,city);



                                },
                              child: Container(
                                height: 40,
                                width: 120,
                                decoration: BoxDecoration(
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
                                    borderRadius: BorderRadius.circular(13)),
                                margin: EdgeInsets.only(top: 25),
                                child: Center(
                                    child: Text(
                                  "Ok",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: AppConstant.fontBold,
                                    fontSize: 12,
                                    decoration: TextDecoration.none,
                                  ),
                                )),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            )));
  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }


  void _uploadProfile(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _uploadimgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _uploadImgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void validation() {
    var name=_Name.text.toString();
    var phone=Contact_Number.text.toString();
    var emailid=Email.text.toString();
    var city=City.text.toString();

    if(name.isEmpty){
      Utils.showToast("Please Enter Name");
    }else if(phone.isEmpty){
      Utils.showToast("Please Enter Number");

    }else if(emailid.isEmpty){
      Utils.showToast("Please Enter Email");

    }else if(city.isEmpty){
      Utils.showToast("Please Enter City");

    }else{

      showDetailsVerifyDialog(name,phone,emailid,city);
    }

  }




  Future<BeanSignUp> signUp(String name, String emailid, String phone, String city) async {
    _progressDialog.show();
    try {
      FormData data = FormData.fromMap({
        "token": "123456789",
        "name": name,
        "mobilenumber": phone,
        "email": emailid,
        "cityid": city,
        "biketype":  _radioValue == 0 ? "Regular":_radioValue==1?"E-Bike":_radioValue==2?"Bicycle":"",
        "youhavelicense": _license==-0?"No":_license==1?"Yes":"",
      });
      BeanSignUp bean = await ApiProvider().registerUser(data);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status ==true) {
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
    } catch (exception) {

      _progressDialog.dismiss();
    }
  }

  validationLogin() {
    var riderId=RiderId.text.toString();
    var password=passwordController.text.toString();
    if(riderId.isEmpty){
      Utils.showToast("Please Enter Rider Id");
    }else if(password.isEmpty){
      Utils.showToast("Please Enter Password");
    }else{
      login(riderId,password);
      print("id"+riderId+password);
    }
  }

  Future<BeanLogin> login(String riderId, String password) async {
    _progressDialog.show();
    try {
      FormData data = FormData.fromMap({
        "token": "123456789",
        "riderid": riderId,
        "password": password,
      });
      print(data);
      BeanLogin bean = await ApiProvider().loginUser(data);
      print(bean.data);
      _progressDialog.dismiss();
      if (bean.status ==true) {
        PrefManager.putBool(AppConstant.session, true);
        PrefManager.putString(AppConstant.user, jsonEncode(bean));
        Utils.showToast(bean.message);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Utils.showToast(bean.message);
      }
    } on HttpException catch (exception) {
      _progressDialog.dismiss();
    } catch (exception) {

      _progressDialog.dismiss();
    }
  }

}
