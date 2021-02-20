

import 'package:agro_farm/Screens/loginpage.dart';
import 'package:agro_farm/Screens/navviewpage.dart';
import 'package:agro_farm/Screens/tabbarviews/homepage.dart';
import 'package:agro_farm/Screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    _createDatabase();
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

  _createDatabase() async{
      String databasePath= await getDatabasesPath();
      String databaseFileName="my_db.db";
      int databaseVersion=1;
      openDatabase(databasePath+"/"+databaseFileName,onCreate: (db, version) {
        String createTableQuery="CREATE TABLE usercart(id INTEGER,cropname TEXT,quantity INTEGER,cropImageUrl TEXT)";
        db.execute(createTableQuery);
        print("created user cart db");
      },
      version: databaseVersion,
      onUpgrade: (db, oldVersion, newVersion) {},
      );
}








