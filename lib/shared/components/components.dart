import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';



Color mainAppColor = Color(0xff4849bf);

void navigateTo(Widget newScreen, BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>newScreen),
  );
}

void navigateToAndCloseAll( newScreen, BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context)=>newScreen),
      (route) => false);
  }

void showToast (String msg){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

String dateTimeFormated(){
  final DateFormat format =DateFormat('dd-MM-yyyy hh:mm:ss');
  final String formattedDate =  format.format(DateTime.now());
  return formattedDate;
}

Widget appBarTitle({required String title}) {
  return  Text(title);
}

