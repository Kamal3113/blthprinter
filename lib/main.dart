import 'package:flutter/material.dart';
import 'package:trady/firstcreen.dart';

import 'package:trady/lanrint.dart';
import 'package:trady/printerdetails.dart';
import 'package:trady/tester.dart';
import 'package:trady/thermalprint.dart';
import 'package:trady/trady.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trady/urldetials.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trady/webviewcom.dart';

import 'getFirestoredata.dart';
Future<void> main() async {
  //  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home:ThermalPrint()
      //Firstcreen()
     // MyHomePage1()
      //Testert()
      // Printerdetails()
 //Urldetail()
 // WebviewCommunication()
 // WifiPrinter(),
    );
  }
}
