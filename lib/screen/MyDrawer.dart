import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/model/BeanSignUp.dart';
import 'package:rider_app/utils/Constents.dart';
import 'package:rider_app/utils/PrefManager.dart';
import 'package:rider_app/utils/Utils.dart';

import '../res.dart';

class MyDrawers extends StatefulWidget {
  @override
  MyDrawersState createState() => MyDrawersState();
}

class MyDrawersState extends State<MyDrawers> {

  BeanSignUp userBean;
  var name="";
  var address="";

  void getUser() async {
    userBean  = await Utils.getUser();
    name=userBean.data.kitchenname;
    address=userBean.data.cityid;
    setState(() {

    });

  }

  bool _switchValue=true;

  int _radioValue = -1;
  void _handleRadioValueChange(int value) {
      _radioValue = value;
      switch (_radioValue) {
        case 0:

          break;

        case 1:

          break;
      }

  }
  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        child: Container(
          width: 250,
          child: Drawer(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: Image.asset(
                    Res.ic_user,
                    width: 90,
                    height: 90,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      name.toString(),
                      style: TextStyle(
                        color: Colors.black,
                          fontFamily: AppConstant.fontBold, fontSize: 18),
                    )),
                Padding(
                    padding: EdgeInsets.only(left: 20, top: 6),
                    child: Text(
                      address,
                      style: TextStyle(
                        color: Colors.grey,
                          fontFamily: AppConstant.fontBold, fontSize: 14),
                    )),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, '/profile');
                  },
                  child: Row(
                    children: [
                      Padding(

                        padding: EdgeInsets.only(left: 16,top: 16),
                          child: Image.asset(Res.ic_my_profile,width: 25,height: 25,),
                      ),

                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            'My Profile',
                            style: TextStyle(
                              color: Colors.black,
                                fontFamily: AppConstant.fontBold, fontSize: 16),
                          )),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Padding(

                      padding: EdgeInsets.only(left: 16,top: 16),
                        child: Image.asset(Res.ic_order,width: 25,height: 25,),
                    ),

                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            'Orders',
                            style: TextStyle(
                              color: Colors.black,
                                fontFamily: AppConstant.fontBold, fontSize: 16),
                          )),
                    ),
                    CupertinoSwitch(
                      value: _switchValue,
                      activeColor: AppConstant.lightGreen,
                      onChanged: (value) {

                        _switchValue = value;
                      },
                    ),
                  ],
                ),

                InkWell(
                  onTap: (){

                    Navigator.pushNamed(context, '/orderhistory');
                  },
                  child: Row(
                    children: [
                     Padding(

                       padding: EdgeInsets.only(left: 16,top: 16),
                       child:  Image.asset(Res.ic_order_history,width: 25,height: 25,),
                     ),

                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            'Order history',
                            style: TextStyle(
                              color: Colors.black,
                                fontFamily: AppConstant.fontBold, fontSize: 16),
                          )),
                    ],
                  ),
                ),

                InkWell(
                  onTap: (){

                    Navigator.pushNamed(context, '/customerfeedback');
                  },
                  child: Row(
                    children: [
                     Padding(
                       padding: EdgeInsets.only(left: 16,top: 16),
                         child:  Image.asset(Res.ic_feedback,width: 25,height: 25,),
                     ),

                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 16),
                          child: Text(
                            'Feedback',
                            style: TextStyle(
                              color: Colors.black,
                                fontFamily: AppConstant.fontBold, fontSize: 16),
                          )),


                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: (){
                        _ackAlert(context);
                      },
                      child: Container(
                        height: 40,
                        width:130,
                        decoration: BoxDecoration(
                            color: AppConstant.lightGreen,
                            borderRadius: BorderRadius.circular(60)),
                        margin: EdgeInsets.only( top: 30,bottom: 16),
                        child: Row(
                          children: [
                            Padding(
                              child:  Image.asset(
                                Res.ic_logout,
                                color: Colors.white,
                                width: 25,
                                height: 25,
                              ),
                              padding: EdgeInsets.only(left: 10),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  'LOGOUT',
                                  style: TextStyle(
                                      fontFamily: AppConstant.fontBold,
                                      fontSize: 12,
                                      color: Colors.white),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )





              ],
            ),

          ),
        ));
  }
  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout!'),
          content: const Text('Are you sure want to logout'),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                PrefManager.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/loginSignUp', (Route<dynamic> route) => false);
              },
            )
          ],
        );
      },
    );



  }

}
