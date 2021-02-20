import 'package:agro_farm/Screens/tabbarviews/homepage.dart';
import 'package:agro_farm/helper/imagehelper.dart';
import 'package:flutter/material.dart';

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
   
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Welcome to Store"),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: false,
            tabs: [_seedTab(), _fertilizerTab()],
          ),
        ),
        body: TabBarView(
          
          // physics: BouncingScrollPhysics(),
          children: [HomePage(), Container()],
        ),

        
      ),
    );
  }

  Widget _seedTab() {
    return Image.asset(seedicon,height: 50,width: 50,);
  }

  Widget _fertilizerTab() {
    return Image.asset(fertilizer,height: 40,width: 50,);
  }
}
