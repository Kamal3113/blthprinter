// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class TestFirestore extends StatefulWidget {
//   const TestFirestore({ Key key }) : super(key: key);

//   @override
//   _TestFirestoreState createState() => _TestFirestoreState();
// }

// class _TestFirestoreState extends State<TestFirestore> {




//     @override
//   void initState(){
//     super.initState();
//    getData();
//   getfirestoredata();
//   }
//   final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('printtest').snapshots();
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(body: Center(child: Text("test"),),);
      

//   }
//   getfirestoredata(){
//     StreamBuilder(
//       stream: FirebaseFirestore.instance.collection('printtest').doc().snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return new Text("Loading");
//         }
//         var userDocument = snapshot.data;
//         print(userDocument["data"]);
//         return new Text(userDocument["data"]);
//     });
//   }
//    getData()async{
//      FirebaseFirestore.instance
//     .collection('printtest').doc('0PVL9Lqv1knfWtdCHpxZ').snapshots().forEach((element) { 
//         // element.docs.forEach((e) {
//         //   print(e.id);
//         //   });
//         print(element.id);
//        });
  
    
//    }
// }