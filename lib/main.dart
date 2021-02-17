
import 'package:AGRO_FARMER/Screens/loginpage.dart';
import 'package:AGRO_FARMER/Screens/navviewpage.dart';
import 'package:AGRO_FARMER/Screens/navviews/homepage.dart';
import 'package:AGRO_FARMER/Screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // defaultTransition: Transition.leftToRight,
      // transitionDuration: Duration(seconds: 5),
      theme: ThemeData(
        primaryColor: Colors.green
      ),
      initialRoute: NavViewPage.idScreen,
        routes: {
          LoginPage.idScreen :(context)=> LoginPage(),

          HomePage.idScreen : (context)=> HomePage(),

          NavViewPage.idScreen : (context)=> NavViewPage(),

          SplashScreen.idScreen : (context)=> SplashScreen()
        
        },

    );
  }
}





