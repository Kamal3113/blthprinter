import 'package:flutter/material.dart';

class Urldetail extends StatefulWidget {


  @override
  State<Urldetail> createState() => _UrldetailState();
}

class _UrldetailState extends State<Urldetail> {
  TextEditingController lictext = new TextEditingController();
   TextEditingController urltext = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
              RaisedButton(  
                  textColor: Colors.white,  
                  color: Colors.blue,  
                  child: Text('Print'),  
                  onPressed: (){},  
                )  ,
                    RaisedButton(  
                  textColor: Colors.white,  
                  color: Colors.blue,  
                  child: Text('Save'),  
                  onPressed: (){},  
                )  
        ],
      ),
      appBar: AppBar(title: Text("Url details"),),
      body: Column(
        children: [
         Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField(  
                    controller:lictext ,
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'License no.',  
                      hintText: 'License no.',  
                    ),  
                  ),  
                ),  
                Padding(  
                  padding: EdgeInsets.all(15),  
                  child: TextField( 
                     controller: urltext, 
                    obscureText: true,  
                    decoration: InputDecoration(  
                      border: OutlineInputBorder(),  
                      labelText: 'Url',  
                      hintText: 'Url',  
                    ),  
                  ),  
                ), 
        ],
      ),
    );
  }
}