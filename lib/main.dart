

import 'package:agro_farm/Screens/loginpage.dart';
import 'package:agro_farm/Screens/navviewpage.dart';
import 'package:agro_farm/Screens/navviews/homepage.dart';
import 'package:agro_farm/Screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      initialRoute: SplashScreen.idScreen,
        routes: {
          LoginPage.idScreen :(context)=> LoginPage(),

          HomePage.idScreen : (context)=> HomePage(),

          NavViewPage.idScreen : (context)=> NavViewPage(),

          SplashScreen.idScreen : (context)=> SplashScreen()
        
        },

    );
  }
}





