import 'package:flutter/material.dart';
import 'package:trady/lanrint.dart';
import 'package:trady/tester.dart';
import 'package:trady/webviewcom.dart';

class Firstcreen extends StatefulWidget {


  @override
  State<Firstcreen> createState() => _FirstcreenState();
}

class _FirstcreenState extends State<Firstcreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Selected Printer"),),
      body:  Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton( shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.black),
),child: Text("Bluetooth printer"),
          onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>Testert()));
          }),
              RaisedButton( shape: RoundedRectangleBorder(
  borderRadius: new BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.black),
),child: Text("Wifi printer"),
          onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>WifiPrinter()));
          })
        ],
      ),),
    );
  }
}