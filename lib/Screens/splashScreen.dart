import 'package:AGRO_FARMER/Custom_Widgets/SlideRight.dart';
import 'package:AGRO_FARMER/Screens/loginpage.dart';
import 'package:flutter/material.dart';

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
      Navigator.push(context, SlideRightRoute(page: LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        body: Container(
          child: Hero(
            tag: "mytag",
            child: Image.asset("images/farmer.jpg",fit: BoxFit.fill,))
        )
      ),
    );
  }
}