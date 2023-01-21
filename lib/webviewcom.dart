import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:trady/data/jsonrestaurant.dart';
import 'package:trady/lanrint.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:path_provider/path_provider.dart';
import 'package:trady/data/data.dart';
import 'package:trady/data/jsonnew.dart';
import 'package:trady/list/Item.dart';
import 'package:trady/list/itemlist.dart';
import 'package:trady/list/jsonclass.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebviewCommunication  extends StatefulWidget {

  @override
  _WebviewComnicationState createState() => _WebviewComnicationState();
}

class _WebviewComnicationState extends State<WebviewCommunication> {
  kitchentest(){
     String complexText =
     """{
    "data": [
        {
            "type": "header",
            "data": {
                "top_title": "",
                "sub_titles": [
                    "Title 1",
                    "Title 2"
                ],
                "address": [
                    "hahaha"
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
                            "hahaha"
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
                    }
                ]
            }
        },
        {
            "type": "summary",
            "data": {
                "key": "Subtotal",
                "value": 91.95,
                "receipt": ""
            }
        },
        {
            "type": "bigsummary",
            "data": {
                "key": "Subtotal",
                "value": 91.95
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
                "receipt_text": [
                    "hahaha"
                ]
            }
        },
        {
            "type": "footer",
            "data": {
                "footer_text": [
                    "hahaha"
                ]
            }
        },
        {
            "type": "logo",
            "data": {
                "url": ""
            }
        }
    ]
}""";
setState(() {
  restaurant = Restaurant.fromJson(jsonDecode(complexText));
});
print(restaurant);
  }
  main() {
 String complexText =
 """{
	"Total": "250.00",
	"GrandTotal": "250.00",
	"BillSummary": [
		{
			"key": "Total Item(s)",
			"value": "1"
		},
		{
			"key": "Discount",
			"value": "0.00"
		},
		{
			"key": "Delivery",
			"value": "0.00"
		},
		{
			"key": "VAT 15%",
			"value": "32.61"
		},
		{
			"key": "Paid Amount",
			"value": "250.00"
		}
	],
	"Header": {
		"HotelName": "Door Shop",
		"Phone": "Tel: 01812391633",
		"currency": "SR",
		"Address": "House 5, Road 4, Nikunja 2, Khilkhet, Dhaka",
		"Address1": "",
		"Address2": "",
		"BillNo": "000093",
		"DateOfBill": "03/02/2022",
		"TimeOfBill": "19:53",
		"OrderType": "Delivery",
		"Table": "",
		"FssaiNo": "",
		"GSTNo": "",
		"CustomerRemarks": "",
		"OrderNote": ""
	},
	"Item": [
		{
			"No": "128",
			"ItemAmt": "250.00",
			"ItemName": "Fish And Chips",
			"alternate_name": null,
			"arabicPrint": "0",
			"itemaddons": "",
			"Qty": "1",
			"Rate": "250.00",
			"modifiers_name": "",
			"modifiers_price": 0,
			"printer_name": "192.168.0.907"
		},
		{
			"No": "128",
			"ItemAmt": "250.00",
			"ItemName": "Fish And Chips",
			"alternate_name": null,
			"arabicPrint": "0",
			"itemaddons": "",
			"Qty": "1",
			"Rate": "250.00",
			"modifiers_name": "",
			"modifiers_price": 0,
			"printer_name": "192.168.0.876"
		},
		{
			"No": "128",
			"ItemAmt": "250.00",
			"ItemName": "Fish And Chips",
			"alternate_name": null,
			"arabicPrint": "0",
			"itemaddons": "",
			"Qty": "1",
			"Rate": "250.00",
			"modifiers_name": "",
			"modifiers_price": 0,
			"printer_name": "192.168.0.907"
		}
	],
	"Settings": {
		"PrinterName": "",
		"PrinterType": "Default",
		"customer_no": "1",
		"ItemLength": 46,
		"PrintLogo": "https://pos.tradywork.com/images/0ad0381dbd8a3441dfdabcb3007f1275.png",
		"qr_path_content": "AQlET09SIFNIT1ACCTIyMjIyMjIyMgMTMjAyMi0wMi0wM1QxOTo1MzowNQQDMjUwBQIzMw==",
		"ThankYouNote": "Thank you for visiting us!",
		"vat_title": "VAT",
		"vat_no": "222222222",
		"invoice_no": "000093",
		"sale_date": "03/02/2022 19:53",
		"sales_man": "Admin User",
		"customer_name": "Sylvester Stallone",
		"waiter_name": "",
		"ThankYouNote2": "",
		"EIDRMK": "",
		"PrintType": "invoice",
		"PageSize": "",
		"auto_print_kot": "1",
		"auto_print_bot": "1"
	}
}""";
setState(() {
  complexTutorial = Autogenerated.fromJson(jsonDecode(complexText));
});
   
  print(complexTutorial);
  Printersd();
}
Restaurant restaurant;
Autogenerated complexTutorial ;
 getData() async {
   String myUrl = "https://techsapphire.net/wp-content/uploads/2022/02/Demo.txt";
    var req = await http.get(myUrl);
    infos =  json.decode(req.body);
   // Food = new Food(name: printlist['data']['title1'],color: Colors.red,id: 1,imageUrl:"dsf" ,modify:[] ,price:23 ,qty:2 ,total:234 );
// Map<String, dynamic> userMap = jsonDecode(req.body);
// var user = Food();
// var user = Item.fromJson(userMap);
    // infos = json.decode(req.body);
    setState(() {
        printlist=  infos;
        });
    print(printlist);
    return printlist;}
  var infos;
  var printlist;
WebViewController controller;
  TextEditingController test= new TextEditingController();
BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice _device;
  bool _connected = false;
  String pathImage;
  Autogenerated autodata;
  var printerlist;
  var seen = Set<String>();
  Printersd(){
setState(() {

printerlist=complexTutorial.item.where((l) => seen.add(l.printerName)).toList();});
// return seen;
 for (int i = 0; i < seen.length; i++){
var fd =   complexTutorial.item.where((d) => d.printerName==seen.toList()[i]);
print(fd.length);
                  }
// print(printerlist);
  }
   @override
  void initState() {
     super.initState();
     
      initPlatformState();
      urlText="https://techsapphire.net";
 //urlText="https://techsapphire.net/wp-content/uploads/2022/02/TwoWayCommunication.html";
     test.text="https://techsapphire.net/wp-content/uploads/2022/02/TwoWayCommunication.html";
 main();
    // getData();
   // kitchentest();
     initSavetoPath();
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
  
  initSavetoPath() async {
  
    final filename = 'pp.png';
    var bytes = await rootBundle.load("asset/pp.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');
    setState(() {
      pathImage = '$dir/$filename';
    });
  }
    Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
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

  var urlText;
  @override
   Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child:  Scaffold(
appBar: new AppBar(title: Container(
                      color: Colors.white,
                      child: TextFormField(
                        controller: test,
                        decoration: InputDecoration(
                          hintText: "Search",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                             IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                               urlText=test.text  ;                       
                           });
                           print(urlText);
                        },
                      ),
                          IconButton(icon: Icon(Icons.wifi), onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>WifiPrinter()));
                          })
                        ],
                      )
                   
                    ],),
      body:
        WebView(
          initialUrl:urlText ,
          // "https://demo.phppointofsale.com",
         // 'https://pos.tradywork.com',
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: <JavascriptChannel>{
            JavascriptChannel(
                name: 'messageHandler',
                onMessageReceived: (JavascriptMessage message) async{

                    print("message from the web view=\"${message.message}\"");
                    
                  //  var printerlist = autodata.item.where((l) => l.printerName.isNotEmpty);
                    //  .Where(i=>!string.IsNullOrEmpty(i.printer_name)).Select(i => i.printer_name).Distinct();
                //   getData();
                 
                      bluetooth.isConnected.then((isConnected) {
                        if (isConnected) {
                         
                          //  ListView.builder(
                          //   itemCount: item.length,
                        
                          //   itemBuilder: (BuildContext context, int index){
bluetooth.printNewLine();
            bluetooth.printCustom(printlist['data']['title1'], 3, 1);
            bluetooth.printNewLine();
            bluetooth.printImage(pathImage);   //path of your image/logo
            bluetooth.printNewLine();
            bluetooth.printLeftRight(printlist['data']['kioskname'] ,"", 0,format: "%1s %45s %n");
          
            bluetooth.printLeftRight(printlist['data']['titteTime'][0]['key2'], printlist['data']['titteTime'][0]['value2'], 1,format: "%1s %33s %n");
 bluetooth.printCustom(printlist['data']['ordernumber'], 3, 1);
 bluetooth.printLeftRight(
                 '---------------------------------------------------------',
                '',
                0);
//  bluetooth.printNewLine();
 bluetooth.printCustom(printlist['data']['typeorder'], 2, 1);
 bluetooth.printCustom(printlist['data']['datetime'], 2, 1);
 bluetooth.printLeftRight(
                 '---------------------------------------------------------',
                '',
                0);
  bluetooth.printNewLine();
  bluetooth.printLeftRight("# Item","Prijs", 1,format: "%1s %40s %n");
  for (int i = 0; i < printlist['data']['items'].length; i++) {
                 bluetooth.printLeftRight(printlist['data']['items'][i]['qty']+"x"+printlist['data']['items'][i]['itemname'],printlist['data']['items'][i]['price'], 1,format: "%1s %34s %n");
        
     
       
         for (int j = 0; j< printlist['data']['items'][i]['itemaddons'].length; j++) {
                bluetooth.printLeftRight(printlist['data']['items'][i]['itemaddons'][j],"",0,format: "%1s %46s %n");
          
                                                                              // var totallength = widget.datalist['items'][0]['name'].length;
                                                                              // var totalpaddings = 30 - totallength;
                                                                              // bluetooth.write(widget.datalist['items'][0]['name'] + "" + "".padLeft(totalpaddings, " ") + widget.datalist['items'][0]['qty'].toString().padLeft(3, " ") + widget.datalist['items'][0]['amount'].padLeft(5, " ") + '300'.padLeft(8, " "));

                                                                            }
                                                                                if(printlist['data']['items'][i]['mainproductcomment']!=''){
 bluetooth.printLeftRight(
                 '---------------------------------------------------------',
                '',
                0);
                 bluetooth.printLeftRight(printlist['data']['items'][i]['mainproductcomment'],"", 1,format: "%1s %40s %n");
              bluetooth.printLeftRight(
                 '---------------------------------------------------------',
                '',
                0);  
        }
                                                                              // var totallength = widget.datalist['items'][0]['name'].length;
                                                                              // var totalpaddings = 30 - totallength;
                                                                              // bluetooth.write(widget.datalist['items'][0]['name'] + "" + "".padLeft(totalpaddings, " ") + widget.datalist['items'][0]['qty'].toString().padLeft(3, " ") + widget.datalist['items'][0]['amount'].padLeft(5, " ") + '300'.padLeft(8, " "));

                                                                            }

          
            bluetooth.printLeftRight(
                '_________________________________________________________',
                '',
                0);
bluetooth.printLeftRight(printlist['data']['subtotal'][0]['key'],printlist['data']['subtotal'][0]['value'], 1,format: "%1s %34s %n");
                   bluetooth.printLeftRight(
                '_________________________________________________________',
                '',
                0);
                
bluetooth.printLeftRight(printlist['data']['Total'][0]['key1'],printlist['data']['Total'][0]['value1'], 1,format: "%1s %34s %n");
                   bluetooth.printLeftRight(
                '_________________________________________________________',
                '',
                0);
             bluetooth.printLeftRight(printlist['data']['summary4'][0]['key'],printlist['data']['summary4'][0]['value'], 1,format: "%1s %34s %n");   
             bluetooth.printLeftRight(
                '_________________________________________________________',
                '',
                0);
                 bluetooth.printCustom(printlist['data']['customtext'], 1, 1);
                   bluetooth.printLeftRight(
                '_________________________________________________________',
                '',
                0);
                bluetooth.printCustom(printlist['data']['address'], 1, 1);
                bluetooth.printCustom(printlist['data']['address1'], 1, 1);
                bluetooth.printCustom(printlist['data']['address2'], 1, 1);
                bluetooth.printCustom(printlist['data']['address3'], 1, 1);
                bluetooth.printCustom(printlist['data']['address4'], 1, 1);
                bluetooth.printCustom(printlist['data']['address5'], 1, 1);
                bluetooth.printCustom(printlist['data']['phone'], 1, 1);
                bluetooth.printCustom(printlist['data']['email'], 1, 1);
                 bluetooth.printCustom(printlist['data']['zipcode'], 1, 1);
                bluetooth.printCustom(printlist['data']['websiteurl'], 1, 1);
                bluetooth.printCustom(printlist['data']['kvknumber'], 1, 1);
                bluetooth.printCustom(printlist['data']['btwnumber'], 1, 1);
                    bluetooth.printLeftRight(
                '_________________________________________________________',
                '',
                0);
                // bluetooth.printCustom(printlist['data'][0]['thankyounote'], 2, 1);
            bluetooth.paperCut();
               
                          
                        }
                      });
                },
            )
        },
      
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
                  content: Container(
                    height: 300,
width: 300,                    child: 
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
}