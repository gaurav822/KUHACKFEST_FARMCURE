import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfilePage extends StatefulWidget {
  
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String phoneNumber="";
  String name="";
  String email="";

  
  _readFarmerDetails()async {
    
    DocumentSnapshot snapshot= await firestore.collection("Farmers").doc(firebaseAuth.currentUser.email).get();
    if(this.mounted){
    setState(() {
    phoneNumber=snapshot.get("phone number"); 
    name= snapshot.get("name");
    email=firebaseAuth.currentUser.email.toString();
    });
    } 
 }


  @override
  void setState(fn){
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
   
    super.initState();
    _readFarmerDetails();
    
  }



  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
        child: Scaffold(
        backgroundColor: Colors.grey.shade200,
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(email),
                Text("Scan QR Code to Know Details",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                Center(
                 child: 
                    QrImage(
                    data: "Email : "+email+" Name : "+name+" Phone number : "+phoneNumber,
                    version: QrVersions.auto,
                    size: 200.0,
                   ),   
                )      
            ],
          ),
        ),
    );
  }
}