import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class FarmerScanner extends StatefulWidget {
  @override
  _FarmerScannerState createState() => _FarmerScannerState();
}

class _FarmerScannerState extends State<FarmerScanner> {

  FirebaseFirestore firestore= FirebaseFirestore.instance;

  String farmersDetails="";

  bool isVerified=false;


  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }

  @override
  void initState() {
    
    super.initState();
    _getUsers();

  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          

          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text("isVerified:"),
              isVerified? Icon(Icons.verified,color: Colors.blue,):Icon(Icons.close,color: Colors.red,)
              ])),
        ],
      ),
    );
   }

  void _onQRViewCreated(QRViewController controller) async{
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;

      });
     if(farmersDetails.contains(result.code.toString())){
       isVerified=true;
       setState(() {
         
       });
     }
     else{
       isVerified=false;
       setState(() {
         
       });
     }
    });
  }

  _getUsers() async{

    print("getting data");
    QuerySnapshot qsnap = await firestore.collection("Farmers").get();
    
    List<QueryDocumentSnapshot> qdocsnaplist= qsnap.docs;

    for(QueryDocumentSnapshot each in qdocsnaplist){

      farmersDetails=farmersDetails+each.data().toString();
    }

    print(farmersDetails);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}