import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Trady extends StatefulWidget {


  @override
  _TradyState createState() => _TradyState();
}

class _TradyState extends State<Trady> {




   WebViewController controller;
BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice _device;
  bool _connected = false;
  String pathImage;




   List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

 Future<void> initPlatformState() async {
    bool isConnected = await bluetooth.isConnected;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            print("bluetooth device state: connected");
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnect requested");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning off");
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth off");
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth on");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning on");
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            print("bluetooth device state: error");
          });
          break;
        default:
          print(state);
          break;
      }
    });
      if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }
  Timer _timer;
      void startTimer() {
    _timer = new Timer.periodic(new Duration(seconds: 10), (time) {
      // getDocs();
    });
  }
 void deactivate() {
    if (_timer.isActive) {
      _timer.cancel();
    } else {
      startTimer();
    }
    super.deactivate();
  }
  @override
  void initState() {
     super.initState();
      initPlatformState();
      //  getDocs();
      // startTimer();
     // Enable virtual display.
  if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
   }
     Future<bool> _onWillPop(BuildContext context) async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child:  Scaffold(
      body:
        WebView(
          initialUrl:
          "https://demo.phppointofsale.com",
         // 'https://pos.tradywork.com',
          javascriptMode: JavascriptMode.unrestricted,
          
          // javascriptChannels: Set.from([
          //       JavascriptChannel(
                  
          //           name: 'Print',
          //           onMessageReceived: (JavascriptMessage message)
                    
          //            {
                
          //             //This is where you receive message from 
          //             //javascript code and handle in Flutter/Dart
          //             //like here, the message is just being printed
          //             //in Run/LogCat window of android studio
          //             print(message.message);
          //           })
          //     ]),
          onWebViewCreated: (controller) {
                      this.controller = controller;
                    },
       )  ,
      floatingActionButton: new FloatingActionButton(
      tooltip: 'Add',
      child: new Icon(Icons.add),
      backgroundColor: new Color(0xFFF44336),
      onPressed: (){
          showDialog(
                context: context,
                builder: (ctxt) => new AlertDialog(
                  title: Text("Text Dialog"),
                  content: Container(child: 
                  ListView(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Device:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButton(
                        items: _getDeviceItems(),
                        onChanged: (value) => setState(() => _device = value),
                        value: _device,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                      onPressed: () {
                        initPlatformState();
                      },
                      child: Text(
                        'Refresh',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: _connected ? Colors.red : Colors.green),
                      onPressed: _connected ? _disconnect : _connect,
                      child: Text(
                        _connected ? 'Disconnect' : 'Connect',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.brown),
                      onPressed: () {
                          bluetooth.isConnected.then((isConnected) {
                        if (isConnected) {
                          bluetooth.printNewLine();
                          bluetooth.printCustom("HEADER", 3, 1);
                          bluetooth.printNewLine();
                          bluetooth.printImage(pathImage); //path of your image/logo
                          bluetooth.printNewLine();
                  //      bluetooth.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
                          bluetooth.printLeftRight("LEFT", "RIGHT", 0);
                          bluetooth.printLeftRight("LEFT", "RIGHT", 1);
                          bluetooth.printLeftRight("LEFT", "RIGHT", 1, format: "%-15s %15s %n");
                          bluetooth.printNewLine();
                          bluetooth.printLeftRight("LEFT", "RIGHT", 2);
                          bluetooth.printLeftRight("LEFT", "RIGHT", 3);
                          bluetooth.printLeftRight("LEFT", "RIGHT", 4);
                          bluetooth.printNewLine();
                          bluetooth.print3Column("Col1", "Col2", "Col3", 1);
                          bluetooth.print3Column("Col1", "Col2", "Col3", 1,
                          format: "%-10s %10s %10s %n");
                          bluetooth.printNewLine();
                          bluetooth.print4Column("Col1", "Col2", "Col3", "Col4", 1);
                          bluetooth.print4Column("Col1", "Col2", "Col3", "Col4", 1,
                          format: "%-8s %7s %7s %7s %n");
                          bluetooth.printNewLine();
                          String testString = " čĆžŽšŠ-H-ščđ";
                          bluetooth.printCustom(testString, 1, 1, charset: "windows-1250");
                          bluetooth.printLeftRight("Številka:", "18000001", 1,
                          charset: "windows-1250");
                          bluetooth.printCustom("Body left", 1, 0);
                          bluetooth.printCustom("Body right", 0, 2);
                          bluetooth.printNewLine();
                          bluetooth.printCustom("Thank You", 2, 1);
                          bluetooth.printNewLine();
                          bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
                          bluetooth.printNewLine();
                          bluetooth.printNewLine();
                          bluetooth.paperCut();
                        }
                      });
                    },
                    child: Text('PRINT TEST',
                    style: TextStyle(color: Colors.white)),
                  ),
                ),
              
              ],
            ),
          ),
          //          actions: <Widget>[
          //   new ListView(
          //     children: <Widget>[
          //       // Row(
          //       //   crossAxisAlignment: CrossAxisAlignment.center,
          //       //   mainAxisAlignment: MainAxisAlignment.start,
          //       //   children: <Widget>[
          //       //     SizedBox(
          //       //       width: 10,
          //       //     ),
          //       //     Text(
          //       //       'Device:',
          //       //       style: TextStyle(
          //       //         fontWeight: FontWeight.bold,
          //       //       ),
          //       //     ),
          //       //     SizedBox(
          //       //       width: 30,
          //       //     ),
          //       //     Expanded(
          //       //       child: DropdownButton(
          //       //         items: _getDeviceItems(),
          //       //         onChanged: (value) => setState(() => _device = value),
          //       //         value: _device,
          //       //       ),
          //       //     ),
          //       //   ],
          //       // ),
          //       // SizedBox(
          //       //   height: 10,
          //       // ),
          //       // Row(
          //       //   crossAxisAlignment: CrossAxisAlignment.center,
          //       //   mainAxisAlignment: MainAxisAlignment.end,
          //       //   children: <Widget>[
          //       //     ElevatedButton(
          //       //       style: ElevatedButton.styleFrom(primary: Colors.brown),
          //       //       onPressed: () {
          //       //         initPlatformState();
          //       //       },
          //       //       child: Text(
          //       //         'Refresh',
          //       //         style: TextStyle(color: Colors.white),
          //       //       ),
          //       //     ),
          //       //     SizedBox(
          //       //       width: 20,
          //       //     ),
          //       //     ElevatedButton(
          //       //       style: ElevatedButton.styleFrom(
          //       //           primary: _connected ? Colors.red : Colors.green),
          //       //       onPressed: _connected ? _disconnect : _connect,
          //       //       child: Text(
          //       //         _connected ? 'Disconnect' : 'Connect',
          //       //         style: TextStyle(color: Colors.white),
          //       //       ),
          //       //     ),
          //       //   ],
          //       // ),
          //       // Padding(
          //       //   padding:
          //       //       const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
          //       //   child: ElevatedButton(
          //       //     style: ElevatedButton.styleFrom(primary: Colors.brown),
          //       //     onPressed: () {
          //       //       // testPrint.sample(pathImage);
          //       //     },
          //       //     child: Text('PRINT TEST',
          //       //         style: TextStyle(color: Colors.white)),
          //       //   ),
          //       // ),
              
          //     ],
          //   ),
          // ],
            )
          );
        }     
      ),     
     ),   
   );
  }
  
  // void getData(){
  //  var data= FirebaseFirestore.instance.collection("printtest").get();
  //  print(data);
  // }
  
  
  void _connect() {
    if (_device == null) {
      show('No device selected.');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected) {
          bluetooth.connect(_device).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }
//   Future getDocs() async {
//     QuerySnapshot querySnapshot = (await FirebaseFirestore.instance.collection("printtest").snapshots()) as QuerySnapshot<Object>;
//     for (int i = 0; i < querySnapshot.docs.length; i++) {
//     var docId=querySnapshot.docs[i];
//     var a = querySnapshot.docs[i]["data"];
//            bluetooth.isConnected.then((isConnected) {
//                         if (isConnected) {
//                           bluetooth.printNewLine();
//                           bluetooth.printCustom("HEADER", 3, 1);
//                           bluetooth.printNewLine();
//                           bluetooth.printImage(pathImage); //path of your image/logo
//                           bluetooth.printNewLine();
//                   //      bluetooth.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
//                           bluetooth.printLeftRight(a, "RIGHT", 0);
//                           bluetooth.printLeftRight("LEFT", "RIGHT", 1);
//                           bluetooth.printLeftRight("LEFT", "RIGHT", 1, format: "%-15s %15s %n");
//                           bluetooth.printNewLine();
//                           bluetooth.printLeftRight("LEFT", "RIGHT", 2);
//                           bluetooth.printLeftRight("LEFT", "RIGHT", 3);
//                           bluetooth.printLeftRight("LEFT", "RIGHT", 4);
//                           bluetooth.printNewLine();
//                           bluetooth.print3Column("Col1", "Col2", "Col3", 1);
//                           bluetooth.print3Column("Col1", "Col2", "Col3", 1,
//                           format: "%-10s %10s %10s %n");
//                           bluetooth.printNewLine();
//                           bluetooth.print4Column("Col1", "Col2", "Col3", "Col4", 1);
//                           bluetooth.print4Column("Col1", "Col2", "Col3", "Col4", 1,
//                           format: "%-8s %7s %7s %7s %n");
//                           bluetooth.printNewLine();
//                           String testString = " čĆžŽšŠ-H-ščđ";
//                           bluetooth.printCustom(testString, 1, 1, charset: "windows-1250");
//                           bluetooth.printLeftRight("Številka:", "18000001", 1,
//                           charset: "windows-1250");
//                           bluetooth.printCustom("Body left", 1, 0);
//                           bluetooth.printCustom("Body right", 0, 2);
//                           bluetooth.printNewLine();
//                           bluetooth.printCustom("Thank You", 2, 1);
//                           bluetooth.printNewLine();
//                           bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
//                           bluetooth.printNewLine();
//                           bluetooth.printNewLine();
//                           bluetooth.paperCut();
//                         }
//                       });
                    
//     print(a);
//     // await FirebaseFirestore.instance.collection("printtest").doc(docId.id).delete();
//   }
// }
  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = false);
  }
  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  
  }
}