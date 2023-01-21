import 'dart:convert';
import 'dart:io';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trady/data/data.dart';
import 'package:trady/data/jsonnew.dart';
import 'package:trady/data/jsonrestaurant.dart';
import 'package:trady/lable.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Testert extends StatefulWidget {
  @override
  State<Testert> createState() => _TestertState();
}

class _TestertState extends State<Testert> {
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

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = false);
  }

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
    void _disconnect() {
      bluetooth.disconnect();
      setState(() => _connected = false);
    }

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

  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice _device;
  bool _connected = false;
  var urlText;
      String pathImage;
  LabelPainter _labelPainter = new LabelPainter();
  @override
  void initState() {
    initPlatformState();
    super.initState();
    urlText = "https://techsapphire.net";

   // main();
     
     initSavetoPath();
  }
 initSavetoPath() async {
    //read and write
    //image max 300px X 300px
    final filename = 'yourlogo.png';
 var bytes = await rootBundle.load("asset/trady.png");
    // ByteData bytes = await _labelPainter.getImageByteData();
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');
    setState(() {
      pathImage = '$dir/$filename';
    });
  }
  //write to app path
  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

      List<String> splitByLength(String value, int length) {
  List<String> pieces = [];

  for (int i = 0; i < value.length; i += length) {
    int offset = i + length;
    pieces.add(value.substring(i, offset >= value.length ? value.length : offset));
  }
  return pieces;
}
  String imageData;
  bool dataLoaded = false;
  var urlist;
  var url;
 _asyncMethod() async {
    for (int s = 0; s < restaurant.data.length; s++){
     urlist = restaurant.data[s].data;
setState(() {
   url = urlist.url;
});
    }
    
    var response = await get(url);
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = documentDirectory.path + "/images";
    var filePathAndName = documentDirectory.path + '/images/pic.jpg'; 
   
    await Directory(firstPath).create(recursive: true);
    File file2 = new File(filePathAndName);            
    file2.writeAsBytesSync(response.bodyBytes);        
    setState(() {
      imageData = filePathAndName;
      dataLoaded = true;
    });
  }

  main() async {
    String complexText = """{
      "printer_name":[
					"EPSON TM-T81 Receipt"
				],
	"item_length":"26",	
      "template":"2",	
    "data": [
       {
            "type": "summary",
            "data":{"summary":[
              {
                "key": "Subtotal",
                "value": 91.95
            }
            ]}
        },
        {
            "type": "header",
            "data": {
                "top_title": "",
                "sub_titles": [
                    "Title 1",
                    "Title 2"
                ],
                "address": [
                    "#122 downtown"
                ],
                "bill_no": "13355",
                "ticket_no": "10",
                "date_of_bill": "3/3/2022",
                "prepration_date": "",
                "time": "11:32 AM",
                "print": "",
                "table": "",
                "online_order_id": "",
                "employee": "User 1",
                "till": "Terminal 2",
                "order_type": "Dine In",
                "customer_name": "",
                "customer_phone": "",
                "customer_address": [
                    "hahaha"
                ],
                "customer_remarks": [
                    "hahaha"
                ],
                "split_bill_string": "",
                "headercomments": [
                    "hahaha"
                ]
            }
        },
        {
			"type": "separator",
			"data": {	
"separator_length":""			
			}
		},
        {
            "type": "item",
            "data": {
                "itemdata": [
                    {
                        "order_invoice_id": 13309,
                        "item_amount": 46.98,
                        "item_name": "Orchard Special 3 pizza 1",
                        "item_subLine": "",
                        "toppings_with_price": [
                            "hahaha"
                        ],
                        "toppings": [
                            "Sugar",
                            "Extra salt",
                            "Cheese"
                        ],
                        "quantity": 1,
                        "selected": false,
                        "price": 44.99,
                        "custpmer_remarks": "",
                        "printer_name": "",
                        "printer_label": "",
                        "station": "",
                        "food_stampable": "",
                        "items": [
                            {
                                "order_invoice_id": "",
                                "item_amount": 0,
                                "item_name": "Garlic Bread 1 ",
                                "item_subLine": "",
                                "toppings_with_price": [
                                    "hahaha"
                                ],
                                "toppings": [
                                    "fg"
                                ],
                                "quantity": 0,
                                "selected": false,
                                "price": 0,
                                "custpmer_remarks": "",
                                "printer_name": "",
                                "printer_label": "",
                                "station": "",
                                "food_stampable": "",
                                "items": [
                                    "we"
                                ],
                                "print_description": "",
                                "deleted": false,
                                "exists": false,
                                "display_index": 0,
                                "is_printed": false,
                                "made_to": false,
                                "menu_group": [
                                    "hahaha"
                                ],
                                "kitchen_print": false
                            }
                        ],
                        "print_description": "",
                        "deleted": false,
                        "exists": false,
                        "display_index": 0,
                        "is_printed": false,
                        "made_to": false,
                        "menu_group": "Combo~10",
                        "kitchen_print": false
                    },
                        {
                        "order_invoice_id": 13309,
                        "item_amount": 46.98,
                        "item_name": "French fire",
                        "item_subLine": "",
                        "toppings_with_price": [
                            "hahaha"
                        ],
                        "toppings": [
                            
                        ],
                        "quantity": 1,
                        "selected": false,
                        "price": 44.99,
                        "custpmer_remarks": "",
                        "printer_name": "",
                        "printer_label": "",
                        "station": "",
                        "food_stampable": "",
                        "items": [
                            {
                                "order_invoice_id": "",
                                "item_amount": 0,
                                "item_name": "Render mest",
                                "item_subLine": "",
                                "toppings_with_price": [
                                    "hahaha"
                                ],
                                "toppings": [
                                    "Salt",
                                    "Extra sauce",
                                    "Chilli"
                                ],
                                "quantity": 0,
                                "selected": false,
                                "price": 0,
                                "custpmer_remarks": "",
                                "printer_name": "",
                                "printer_label": "",
                                "station": "",
                                "food_stampable": "",
                                "items": [
                                    "we"
                                ],
                                "print_description": "",
                                "deleted": false,
                                "exists": false,
                                "display_index": 0,
                                "is_printed": false,
                                "made_to": false,
                                "menu_group": [
                                    "hahaha"
                                ],
                                "kitchen_print": false
                            }
                        ],
                        "print_description": "",
                        "deleted": false,
                        "exists": false,
                        "display_index": 0,
                        "is_printed": false,
                        "made_to": false,
                        "menu_group": "Combo~10",
                        "kitchen_print": false
                    }
                ]
            }
        },
       {
			"type": "separator",
			"data": {	
"separator_length":""			
			}
		},
       {
    "type": "bigsummary",
    "data": {"bigsummary":
      [
        {
            "key": "Subtotal",
            "value": 91.95
        },
        {
            "key": "Total",
            "value": 43.96
        },
        {
            "key": "PaidAmount",
            "value": 43.96
        },
        {
            "key": "TaxTotal",
            "value": 5.73
        }
    ]}
},
        {
			"type": "separator",
			"data": {	
"separator_length":""			
			}
		},
    {
            "type": "item",
            "data": {
                "itemdata": [
                    {
                        "order_invoice_id": 13309,
                        "item_amount": 46.98,
                        "item_name": "Orchard Special 3 pizza",
                        "item_subLine": "",
                        "toppings_with_price": [
                            "hahaha"
                        ],
                        "toppings": [
                            "Sugar",
                            "Extra salt",
                            "Cheese"
                        ],
                        "quantity": 1,
                        "selected": false,
                        "price": 44.99,
                        "custpmer_remarks": "",
                        "printer_name": "",
                        "printer_label": "",
                        "station": "",
                        "food_stampable": "",
                        "items": [
                            {
                                "order_invoice_id": "",
                                "item_amount": 0,
                                "item_name": "Garlic Bread 1 ",
                                "item_subLine": "",
                                "toppings_with_price": [
                                    "hahaha"
                                ],
                                "toppings": [
                                    "fg"
                                ],
                                "quantity": 0,
                                "selected": false,
                                "price": 0,
                                "custpmer_remarks": "",
                                "printer_name": "",
                                "printer_label": "",
                                "station": "",
                                "food_stampable": "",
                                "items": [
                                    "we"
                                ],
                                "print_description": "",
                                "deleted": false,
                                "exists": false,
                                "display_index": 0,
                                "is_printed": false,
                                "made_to": false,
                                "menu_group": [
                                    "hahaha"
                                ],
                                "kitchen_print": false
                            }
                        ],
                        "print_description": "",
                        "deleted": false,
                        "exists": false,
                        "display_index": 0,
                        "is_printed": false,
                        "made_to": false,
                        "menu_group": "Combo~10",
                        "kitchen_print": false
                    },
                        {
                        "order_invoice_id": 13309,
                        "item_amount": 46.98,
                        "item_name": "French fire",
                        "item_subLine": "",
                        "toppings_with_price": [
                            "hahaha"
                        ],
                        "toppings": [
                            
                        ],
                        "quantity": 1,
                        "selected": false,
                        "price": 44.99,
                        "custpmer_remarks": "",
                        "printer_name": "",
                        "printer_label": "",
                        "station": "",
                        "food_stampable": "",
                        "items": [
                            {
                                "order_invoice_id": "",
                                "item_amount": 0,
                                "item_name": "Render mest",
                                "item_subLine": "",
                                "toppings_with_price": [
                                    "hahaha"
                                ],
                                "toppings": [
                                    "Salt",
                                    "Extra sauce",
                                    "Chilli"
                                ],
                                "quantity": 0,
                                "selected": false,
                                "price": 0,
                                "custpmer_remarks": "",
                                "printer_name": "",
                                "printer_label": "",
                                "station": "",
                                "food_stampable": "",
                                "items": [
                                    "we"
                                ],
                                "print_description": "",
                                "deleted": false,
                                "exists": false,
                                "display_index": 0,
                                "is_printed": false,
                                "made_to": false,
                                "menu_group": [
                                    "hahaha"
                                ],
                                "kitchen_print": false
                            }
                        ],
                        "print_description": "",
                        "deleted": false,
                        "exists": false,
                        "display_index": 0,
                        "is_printed": false,
                        "made_to": false,
                        "menu_group": "Combo~10",
                        "kitchen_print": false
                    }
                ]
            }
        },
    {
            "type": "setting",
            "data": {
                "printer_name": [
                    "EPSON TM-T81 Receipt"
                ],
                "print_type": "",
                "item_length": 30,
                "print_logo": false,
                "thankyou_note": "",
                "thankyou_note2": "",
                "printer_type": "POS"
            }
        },
          {
			"type": "separator",
			"data": {	
"separator_length":""			
			}
		},
        {
            "type": "columndetails",
            "data": {
                "columnheader": {
                    "column1": "Tax",
                    "column2": "Over",
                    "column3": "",
                    "column4": "tax"
                },
                "columndata": [
                    {
                        "column1": "0%",
                        "column2": "0,00",
                        "column3": "",
                        "column4": "0,00"
                    },
                    {
                        "column1": "9%",
                        "column2": "10,00",
                        "column3": "",
                        "column4": "0,83"
                    },
                    {
                        "column1": "21%",
                        "column2": "0,00",
                        "column3": "",
                        "column4": "0,00"
                    },
                    {
                        "column1": "Total",
                        "column2": "10,00",
                        "column3": "",
                        "column4": "0,83"
                    }
                ]
            }
        },
        {
            "type": "Receipt",
            "data": {
              "align":"center",
                "receipt_text": [
                    "hahaha"
                ]
            }
        },
        {
			"type": "separator",
			"data": {	
"separator_length":""			
			}
		},
        {
            "type": "footer",
            "data": {
              "align":"center",
                "footer_text": [
                    "Hotsport development agency",
                    "350012, near dinning hall",
                    "Bookdev",
                    "Gujrat",
                    "BTN - 85823648",
                    "petorlrec@12gmail.com"
                ]
            }
        },
        {
            "type": "logo",
            "data": {
                "url": "https://pos.tradywork.com/images/22bef43a88f72e2a0e57992865302ba4.png"
            }
        }
    ]
}""";
    setState(() {
      restaurant = Restaurant.fromJson(jsonDecode(complexText));
      print(restaurant);

  itemslength = int.parse(restaurant.itemLength);

      //  restaurant = resBody;
      //  restaurant = Restaurant.fromJson(jsonDecode(complexText));
    });
    _asyncMethod();
//  for (int i = 0; i < restaurant.data.length; i++){
//    setState(() {
//          datalist = restaurant.data[i].data;

//       });
//     print(datalist);
//   }
    // print(restaurant);
  }
  var itemslength;
double df =0.6;
double slctitem =1.8;
Text sd = Text("Selected Item",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold));
  var datalist;
  var datalistitem;
  var datalistsummary;
  var databigsummary;
  var footerlist;
  var taxlist;
  // Autogenerated autogenerated;
  Restaurant restaurant;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
          initialUrl: urlText,
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: <JavascriptChannel>{
            JavascriptChannel(
                name: 'messageHandler',
                onMessageReceived: (JavascriptMessage message) async {
                  print(message.message);
                    restaurant = Restaurant.fromJson(jsonDecode(message.message));
      print(restaurant);
   _asyncMethod();
  itemslength = int.parse(restaurant.itemLength);
                    //   bluetooth.isConnected.then((isConnected) {
                    //     if (isConnected) {
                    //       bluetooth.printNewLine();
                    //       bluetooth.printCustom("HEADERa", 3, 100);
                    //       bluetooth.printNewLine();
                    // bluetooth.printImage(pathImage);
                    //       String testString = " čĆžŽšŠ-H-ščđ";
                    //       bluetooth.printCustom(testString, 1, 1, charset: "windows-1250");
                    //       bluetooth.printLeftRight("Številka:", "18000001", 1,
                    //       charset: "windows-1250");
                    //       bluetooth.printCustom("Body left", 1, 0);
                    //       bluetooth.printCustom("Body right", 0, 2);
                        
                    //       bluetooth.paperCut();
                    //     }
                    //   });
                  bluetooth.isConnected.then((isConnected) {
               bluetooth.printImage(imageData);
                     bluetooth.printNewLine();
                    for (int j = 0; j < restaurant.data.length; j++) {
                      if(restaurant.template=="2"){
                                                if (restaurant.data[j].type == "columndetails"){
                           taxlist = restaurant.data[j].data;
                            bluetooth.print3Column(taxlist.columnheader.column1, taxlist.columnheader.column2, taxlist.columnheader.column4, 1);
  for (int k = 0; k < taxlist.columndata.length; k++){
 bluetooth.print3Column(taxlist.columndata[k].column1, taxlist.columndata[k].column2, taxlist.columndata[k].column4, 1);
}}
       if (restaurant.data[j].type == "footer"){
                   footerlist = restaurant.data[j].data;
                   for (int d = 0; d < footerlist.footerText.length; d++){
if(footerlist.align=="center"){
 
bluetooth.write(footerlist.footerText[d]);
bluetooth.printNewLine();


}
else if(footerlist.align=="left"){

  bluetooth.printLeftRight("", footerlist.footerText[d], 1,
                            format: "%-25s %15s %n");
}
else{
 bluetooth.printCustom(footerlist.footerText[d], 1, 2);
}
}
                   }
                      if (restaurant.data[j].type == "separator"){
                        bluetooth.printLeftRight(
                            "________________________________________________",
                            "",
                            1);
                      }
                      if (restaurant.data[j].type == "header") {
                        datalist = restaurant.data[j].data;
                        if (datalist.topTitle == "") {
                          bluetooth.write("");
                        } else {
                          bluetooth.printCustom(datalist.topTitle, 2, 1);

                        }

bluetooth.printCustom("#"+datalist.ticketNo, 3, 1);
                      bluetooth.printCustom("#"+datalist.billNo, 2, 1);
                        bluetooth.printLeftRight(
                            "________________________________________________",
                            "",
                            1);
  bluetooth.printCustom("POS", 3, 1);
    bluetooth.printCustom(datalist.dateOfBill +" "+  datalist.time, 2, 1);
                    
                      }
                      if (restaurant.data[j].type == "item") {
                        datalistitem = restaurant.data[j].data;

                        bluetooth.printLeftRight(sd.data, "", slctitem.toInt(),
                            format: "%10s %40s %n");
                        for (int k = 0; k < datalistitem.itemdata.length; k++) {
                          var printsplit= splitByLength(datalistitem.itemdata[k].itemName, itemslength);

print(printsplit);
                          bluetooth.printLeftRight(
                              datalistitem.itemdata[k].quantity.toString() +
                                  " x " +
                              printsplit[0],
                         
                              datalistitem.itemdata[k].itemAmount.toString(),
                              1,
                              format: "%-30s %15s %n");
                              if(printsplit.length >1){
      int skip=1;
for (int t = 1; t < printsplit.length; t++){
bluetooth.printLeftRight(
                              printsplit[t],
                              "",
                              1,
                              format: "%-40s %15s %n");
   
    }
    }
                          for (int l = 0;
                              l < datalistitem.itemdata[k].toppings.length;
                              l++) {
                            bluetooth.printLeftRight(
                               "x "+ datalistitem.itemdata[k].toppings[l], "",df.toInt() ,
                                format: "%-25s %20s %n");
                          }
                             for (int m = 0;
                              m < datalistitem.itemdata[k].items.length;
                              m++) {
                            bluetooth.printLeftRight(
                                datalistitem.itemdata[k].items[m].itemName, "", 1,
                                format: "%-25s %15s %n");
                                 for (int n = 0;
                              n < datalistitem.itemdata[k].items[m].toppings.length;
                              n++) {
                                
                            bluetooth.printLeftRight(
                               "x "+ datalistitem.itemdata[k].items[m].toppings[n], "", df.toInt(),
                                format: "%-25s %20s %n");
                                
                          }
                          }
                           
                        }
                      }
                      if (restaurant.data[j].type == "summary") {
                        datalistsummary = restaurant.data[j].data;
                        bluetooth.printNewLine();
                        //  bluetooth.write("------------------------------------------------");
                       // bluetooth.write("---------------------------------------------------------");
                        bluetooth.printLeftRight(datalistsummary.summary[0].key,
                            datalistsummary.summary[0].value.toString(), 1,
                            format: "%-25s %15s %n");
                     bluetooth.write("------------------------------------------------");
                        // bluetooth.printLeftRight(datalistsummary.key, datalistsummary.value.toString(), 1,
                        //   format: "%-25s %15s %n");
                      }
                      if (restaurant.data[j].type == "bigsummary") {
                        databigsummary = restaurant.data[j].data;
                      for (int e = 0;e < databigsummary.bigsummary.length;
                              e++){
bluetooth.printLeftRight(databigsummary.bigsummary[e].key,
    databigsummary.bigsummary[e].value.toString(), 1,
    format: "%-25s %15s %n");
                              }
                        // bluetooth.printLeftRight("Total",
                        //     databigsummary.total.toString(), 1,
                        //     format: "%-25s %15s %n");
                        //      bluetooth.printLeftRight("Includes GST of",
                        //     databigsummary.taxTotal.toString(), 1,
                        //     format: "%-25s %15s %n");
                         
                        //     bluetooth.printLeftRight("Amount Piad",
                        //     databigsummary.paidAmount.toString(), 1,
                        //     format: "%-25s %15s %n");
                           
                         
                        //     bluetooth.printLeftRight("Payments:",
                        //     "", 1,
                        //     format: "%-25s %15s %n");
                        // bluetooth.write("------------------------------------------------");
                        //       bluetooth.printCustom(">>>Order No. #"+datalist.ticketNo+"<<<", 1, 1);
                        // bluetooth.printLeftRight(datalistsummary.key, datalistsummary.value.toString(), 1,
                        //   format: "%-25s %15s %n");
                      }
 }else{
           if (restaurant.data[j].type == "footer"){
                   footerlist = restaurant.data[j].data;
                   for (int d = 0; d < footerlist.footerText.length; d++){
if(footerlist.align=="center"){
 
bluetooth.write(footerlist.footerText[d]);
bluetooth.printNewLine();


}
else if(footerlist.align=="left"){

  bluetooth.printLeftRight("", footerlist.footerText[d], 1,
                            format: "%-25s %15s %n");
}
else{
 bluetooth.printCustom(footerlist.footerText[d], 1, 2);
}
}
                   }
                      if (restaurant.data[j].type == "separator"){
                        bluetooth.printLeftRight(
                            "________________________________________________",
                            "",
                            1);
                      }
                      if (restaurant.data[j].type == "header") {
                        datalist = restaurant.data[j].data;
                        if (datalist.topTitle == "") {
                          bluetooth.write("");
                        } else {
                          bluetooth.printCustom(datalist.topTitle, 2, 1);

                        }

                        for (int k = 0; k < datalist.subTitles.length; k++) {
                          bluetooth.printCustom(datalist.subTitles[k], 2, 1);
                        }
                        for (int k = 0; k < datalist.address.length; k++) {
                          bluetooth.printCustom(datalist.address[k], 2, 1);
                        }
                        bluetooth.printLeftRight(
                            "________________________________________________",
                            "",
                            1);

                        bluetooth.printLeftRight(
                            datalist.orderType, datalist.ticketNo, 1,
                            format: "%-25s %15s %n");
                        bluetooth.write("________________________________________________");
                            
                        bluetooth.printLeftRight("Time", datalist.time, 1,
                            format: "%-25s %15s %n");
                        bluetooth.printLeftRight(
                            "Employee", datalist.employee, 1,
                            format: "%-25s %15s %n");
                        bluetooth.printLeftRight("Terminal", datalist.till, 1,
                            format: "%-25s %15s %n");

                        //bluetooth.write("------------------------------------------------");

                        // bluetooth.printNewLine();

// bluetooth.printCustom(datalist.billNo, 3, 1);
// bluetooth.printCustom(datalist.ticketNo, 3, 1);
// bluetooth.printCustom(datalist.dateOfBill, 3, 1);
//  if(datalist.preprationDate==""){
//   bluetooth.write("");
//  }
//  else{
// bluetooth.printCustom(datalist.preprationDate, 3, 1);
//  }
// //  bluetooth.printCustom(datalist.time, 3, 1);
//   if(datalist.print==""){
//   bluetooth.write("");
//  }
//  else{
// bluetooth.printCustom(datalist.print, 3, 1);
//  }
//   if(datalist.table==""){
//   bluetooth.write("");
//  }
//  else{
// bluetooth.printCustom(datalist.table, 3, 1);
//  }
//    if(datalist.onlineOrderId==""){
//   bluetooth.write("");
//  }
//  else{
// bluetooth.printCustom(datalist.onlineOrderId, 3, 1);
//  }
//  bluetooth.printCustom(datalist.employee, 3, 1);
//   bluetooth.printCustom(datalist.till, 3, 1);
//    bluetooth.printCustom(datalist.orderType, 3, 1);
//      if(datalist.customerName==""){
//   bluetooth.write("");
//  }
//  else{
// bluetooth.printCustom(datalist.customerName, 3, 1);
//  }
//    if(datalist.customerPhone==""){
//   bluetooth.write("");
//  }
//  else{
// bluetooth.printCustom(datalist.customerPhone, 3, 1);
//  }
//     for (int m = 0; m < datalist.customerAddress.length; m++){
// bluetooth.printCustom(datalist.customerAddress[m], 3, 1);
//     }
//        for (int n = 0; n < datalist.customerRemarks.length; n++){
// bluetooth.printCustom(datalist.customerRemarks[n], 3, 1);
//     }
//       if(datalist.splitBillString==""){
//   bluetooth.write("");
//  }
//  else{
//  bluetooth.printCustom(datalist.splitBillString, 3, 1);
//  }

//      for (int o = 0; o < datalist.headercomments.length; o++){
// bluetooth.printCustom(datalist.headercomments[o], 3, 1);
//     }

                        //        2 }

                      }
                      if (restaurant.data[j].type == "item") {
                        datalistitem = restaurant.data[j].data;
// bluetooth.write(sd.data);
// bluetooth.printNewLine();
                        bluetooth.printLeftRight(sd.data, "", slctitem.toInt(),
                            format: "%10s %40s %n");
                        for (int k = 0; k < datalistitem.itemdata.length; k++) {
                          var printsplit= splitByLength(datalistitem.itemdata[k].itemName, 22);

print(printsplit);
                          bluetooth.printLeftRight(
                              datalistitem.itemdata[k].quantity.toString() +
                                  " x " +
                              printsplit[0],
                             //  datalistitem.itemdata[k].itemName,
                              datalistitem.itemdata[k].itemAmount.toString(),
                              1,
                              format: "%-30s %15s %n");
                              if(printsplit.length >1){
      int skip=1;
for (int t = 1; t < printsplit.length; t++){
bluetooth.printLeftRight(
                              printsplit[t],
                              "",
                              1,
                              format: "%-30s %15s %n");
    // skip= skip +1;
    }
    }
                          for (int l = 0;
                              l < datalistitem.itemdata[k].toppings.length;
                              l++) {
                            bluetooth.printLeftRight(
                               "x "+ datalistitem.itemdata[k].toppings[l], "",df.toInt() ,
                                format: "%-25s %20s %n");
                          }
                             for (int m = 0;
                              m < datalistitem.itemdata[k].items.length;
                              m++) {
                            bluetooth.printLeftRight(
                                datalistitem.itemdata[k].items[m].itemName, "", 1,
                                format: "%-25s %15s %n");
                                 for (int n = 0;
                              n < datalistitem.itemdata[k].items[m].toppings.length;
                              n++) {
                                
                            bluetooth.printLeftRight(
                               "x "+ datalistitem.itemdata[k].items[m].toppings[n], "", df.toInt(),
                                format: "%-25s %20s %n");
                                
                          }
                          }
                           
//  bluetooth.printCustom(datalistitem.itemdata[k].orderInvoiceId.toString(), 3, 1);
//   bluetooth.printCustom(datalistitem.itemdata[k].itemAmount.toString(), 3, 1);
//  bluetooth.printCustom(datalistitem.itemdata[k].itemName , 3, 1);
                          // if (datalistitem.itemdata[k].itemSubLine == "") {
                          //   bluetooth.write("");
                          // } else {
                          //   bluetooth.printCustom(
                          //       datalistitem.itemdata[k].itemSubLine, 3, 1);
                          // }
                          // for (int l = 0;
                          //     l <
                          //         datalistitem
                          //             .itemdata[k].toppingsWithPrice.length;
                          //     l++) {
                          //   bluetooth.printCustom(
                          //       datalistitem.itemdata[k].toppingsWithPrice[l],
                          //       3,
                          //       1);
                          // }
                          // for (int m = 0;
                          //     m < datalistitem.itemdata[k].toppings.length;
                          //     m++) {
                          //   bluetooth.printCustom(
                          //       datalistitem.itemdata[k].toppings[m], 3, 1);
                          // }
                          // bluetooth.printCustom(
                          //     datalistitem.itemdata[k].quantity.toString(),
                          //     3,
                          //     1);
                          // bluetooth.printCustom(
                          //     datalistitem.itemdata[k].price.toString(), 3, 1);
                          // for (int n = 0;
                          //     n < datalistitem.itemdata[k].items.length;
                          //     n++) {
                          //   bluetooth.printCustom(
                          //       datalistitem.itemdata[k].items[n].itemAmount
                          //           .toString(),
                          //       3,
                          //       1);
                          //   bluetooth.printCustom(
                          //       datalistitem.itemdata[k].items[n].itemName,
                          //       3,
                          //       1);
                          //   for (int l = 0;
                          //       l <
                          //           datalistitem.itemdata[k].items[n]
                          //               .toppingsWithPrice.length;
                          //       l++) {
                          //     bluetooth.printCustom(
                          //         datalistitem.itemdata[k].items[n]
                          //             .toppingsWithPrice[l],
                          //         3,
                          //         1);
                          //   }
                          //   for (int m = 0;
                          //       m <
                          //           datalistitem
                          //               .itemdata[k].items[n].toppings.length;
                          //       m++) {
                          //     bluetooth.printCustom(
                          //         datalistitem.itemdata[k].items[n].toppings[m],
                          //         3,
                          //         1);
                          //   }
                          //   bluetooth.printCustom(
                          //       datalistitem.itemdata[k].items[n].quantity
                          //           .toString(),
                          //       3,
                          //       1);
                          //   bluetooth.printCustom(
                          //       datalistitem.itemdata[k].items[n].price
                          //           .toString(),
                          //       3,
                          //       1);
                          // }
                        }
                      }
                      if (restaurant.data[j].type == "summary") {
                        datalistsummary = restaurant.data[j].data;
                        bluetooth.printNewLine();
                         bluetooth.write("------------------------------------------------");
                       // bluetooth.write("---------------------------------------------------------");
                        bluetooth.printLeftRight(datalistsummary.summary[0].key,
                            datalistsummary.summary[0].value.toString(), 1,
                            format: "%-25s %15s %n");
                     bluetooth.write("------------------------------------------------");
                        // bluetooth.printLeftRight(datalistsummary.key, datalistsummary.value.toString(), 1,
                        //   format: "%-25s %15s %n");
                      }
                      if (restaurant.data[j].type == "bigsummary") {
                        databigsummary = restaurant.data[j].data;
                      for (int e = 0;e < databigsummary.bigsummary.length;
                              e++){
bluetooth.printLeftRight(databigsummary.bigsummary[e].key,
    databigsummary.bigsummary[e].value.toString(), 1,
    format: "%-25s %15s %n");
                              }
                        // bluetooth.printLeftRight("Total",
                        //     databigsummary.total.toString(), 1,
                        //     format: "%-25s %15s %n");
                        //      bluetooth.printLeftRight("Includes GST of",
                        //     databigsummary.taxTotal.toString(), 1,
                        //     format: "%-25s %15s %n");
                         
                        //     bluetooth.printLeftRight("Amount Piad",
                        //     databigsummary.paidAmount.toString(), 1,
                        //     format: "%-25s %15s %n");
                           
                         
                        //     bluetooth.printLeftRight("Payments:",
                        //     "", 1,
                        //     format: "%-25s %15s %n");
                        // bluetooth.write("------------------------------------------------");
                        //       bluetooth.printCustom(">>>Order No. #"+datalist.ticketNo+"<<<", 1, 1);
                        // bluetooth.printLeftRight(datalistsummary.key, datalistsummary.value.toString(), 1,
                        //   format: "%-25s %15s %n");
                      }
                  
                      }
                 
                    }
                     bluetooth.printNewLine();
                          bluetooth.printNewLine();
                    bluetooth.paperCut();
                  });
                })
          }),
      floatingActionButton: new FloatingActionButton(
          tooltip: 'Add',
          child: new Icon(Icons.add),
          backgroundColor: new Color(0xFFF44336),
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctxt) => new AlertDialog(
                      title: Text("Text Dialog"),
                      content: Container(
                        height: 300,
                        width: 300,
                        child: ListView(
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
                                    onChanged: (value) =>
                                        setState(() => _device = value),
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
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.brown),
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
                                      primary: _connected
                                          ? Colors.red
                                          : Colors.green),
                                  onPressed:
                                      _connected ? _disconnect : _connect,
                                  child: Text(
                                    _connected ? 'Disconnect' : 'Connect',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ));
          }),
    );
  }
}
