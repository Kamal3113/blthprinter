import 'package:flutter/material.dart';
import 'package:trady/sqldata.dart';

class Printerdetails extends StatefulWidget {
  

  @override
  State<Printerdetails> createState() => _printerdetailsState();
}

class _printerdetailsState extends State<Printerdetails> {
  final DBPrinterManager dbPrinterManager = new DBPrinterManager();
  final _formkey = new GlobalKey<FormState>();
  Printer prt;
  int updateindex;

  List<Printer> prtlist;
    TextEditingController urltext = new TextEditingController();
  TextEditingController lictext = new TextEditingController();
   TextEditingController printername = new TextEditingController();
   TextEditingController printeraddress = new TextEditingController();
  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Printer"),
      ),
      body:  Column(
        children: [
           Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    controller:urltext ,
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Url',  
                      hintText: 'Url',  
                    ),  
                  ),  
                ), 
         Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    controller:lictext ,
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Lic no.',  
                      hintText: 'Lic no.',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child:ListTile(
                    title: Text("Kitchen"),
                    trailing: IconButton(icon: Icon(Icons.add), onPressed: (){
                    showDialog(context: context, builder: (context)=> new AlertDialog(
 title: Text("Kitchen printer"),
                  content: Container(
          height: 250,
child:  Form(key: _formkey
  ,child: Column(  
              children: <Widget>[  
               
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    controller: printername,
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Printer Name',  
                      hintText: 'Printer Name',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    controller: printeraddress,
                   
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Printer address',  
                      hintText: 'Printer address',  
                    ),  
                  ),  
                ),  
                RaisedButton(  
                  textColor: Colors.white,  
                  color: Colors.blue,  
                  child: Text('SUBMIT'),  
                  onPressed: (){
                    submitStudent(context);
                    Navigator.pop(context);
                  },  
                )  
              ],  
            )  )
        )       )
                    );
                    }),
                  )
                ),
                FutureBuilder(
                    future: dbPrinterManager.getprinterList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        prtlist = snapshot.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: prtlist == null ? 0 : prtlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            Printer st = prtlist[index];
                            return Card(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Container(
                                      width: width * 0.50,
                                      child: Column(
                                        children: <Widget>[
                                        
                                          Text('Name: ${st.name}'),
                                           Text('Address: ${st.address}'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // IconButton(
                                  //   onPressed: () {
                                  //     printername.text = st.name;
                                  //     printername.text = st.address;
                                  //     prt = st;
                                  //     updateindex = index;
                                  //   },
                                  //   icon: Icon(
                                  //     Icons.edit,
                                  //     color: Colors.blue,
                                  //   ),
                                  // ),
                                  IconButton(
                                    onPressed: () {
                                      dbPrinterManager.deleteprinter(st.id);
                                      setState(() {
                                        prtlist.removeAt(index);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      return CircularProgressIndicator();
                    },
                  )   
        ],
      ),
    );
  }
   void submitStudent(BuildContext context) { 
    if (_formkey.currentState.validate()) {
      if (prt == null) {
        Printer st = new Printer(
            name: printername.text, address: printeraddress.text);
        dbPrinterManager.insertprinter(st).then((value) => {
              printername.clear(),
              printeraddress.clear(),
              print("printerlist Data Add to database $value"),
            });
      } else {
        prt.name = printername.text;
        prt.address = printeraddress.text;

        // dbStudentManager.update(prt).then((value) {
        //   setState(() {
        //     prtlist[updateindex].name = printername.text;
        //     prtlist[updateindex].address = printeraddress.text;
        //   });
        //   printername.clear();
        //   printeraddress.clear();
        //   prt = null;
        // });
      }
    }}
}


    