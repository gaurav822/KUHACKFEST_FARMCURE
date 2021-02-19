import 'package:agro_farm/Screens/navviews/cropspage.dart';
import 'package:agro_farm/Screens/tabbarviews/homepage.dart';
import 'package:agro_farm/Screens/navviews/mycartview.dart';
import 'package:agro_farm/Screens/navviews/profilepage.dart';
import 'package:agro_farm/Screens/navviews/walletpage.dart';
import 'package:agro_farm/Screens/tabviews.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavViewPage extends StatefulWidget {

  static const String idScreen="navview";

  @override
  _NavViewPageState createState() => _NavViewPageState();
}

class _NavViewPageState extends State<NavViewPage> {
  int _currentIndex = 0;
   List<Widget> pages = [CropsPage(),TabView(),CartView(),ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[_currentIndex],
      
      bottomNavigationBar: _myBottomNavbar(),
      
    );
  }

  Widget _myBottomNavbar(){

    return Container(

      child: BottomNavigationBar(
        
        iconSize: 35,
        showUnselectedLabels: true,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey.shade700,
        backgroundColor: Colors.blue,
        // type: BottomNavigationBarType.shifting,

        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
        currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(label: "Recommend Crops",icon: Image.asset("images/crop.png",height: 40,)),
            BottomNavigationBarItem(label: "Store", icon:Icon(Icons.shop)),
            BottomNavigationBarItem(label: "My Cart",icon: Icon(FontAwesomeIcons.cartPlus)),
            // BottomNavigationBarItem(label: "My Wallet",icon: Icon(Icons.wallet_travel)),
            BottomNavigationBarItem(label: "Profile",icon: Icon(FontAwesomeIcons.userCircle)),
          ],
        ),
    );
  }
}