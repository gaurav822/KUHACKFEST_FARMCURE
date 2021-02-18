
import 'package:agro_farm/Screens/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
 static const String idScreen="splash";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _gotoLoginScreen();
    super.initState();
  }

  _gotoLoginScreen() async{

  await Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> LoginPage()), (route) => false);

    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        body: Stack(
                  children: [
            Container(
            child:  Image.asset("images/back.jpg",fit: BoxFit.fill,height: Get.height,)),

            Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(height: Get.height*.1,),
                  Text("Welcome to Agro Farming", style: TextStyle(color: Colors.green,fontSize: 25,fontWeight: FontWeight.bold),),
                  SizedBox(height: Get.height*.01,),
                  // Text("(We help you grow! we help you find best crops)",style: TextStyle(color: Colors.deepOrange),),
                  SizedBox(height: Get.height*.1,),
                  Container(
                        decoration: BoxDecoration(),
                        height: 150,
                        width: 150,
                        child: Hero(
                          tag: "farmer",
                          child: CircleAvatar(
                          backgroundImage: AssetImage("images/farmer.jpg")),
                        )),
                  SizedBox(height: Get.height*.3,),
                  Center(child: CircularProgressIndicator(backgroundColor: Colors.white,))
                ],
              ),
            )
            
            ]
        )
        )
    );
  }
}