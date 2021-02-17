import 'package:AGRO_FARMER/helper/imagehelper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
   static const String idScreen="home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List  cropsDetails= [

    {
      "image":wheat,
      "price":"Rs.200",
      'name': 'wheat'
    },
    {
      "image":mustard,
      "price":"Rs.200",
      'name': 'mustard'
    },
    {
      "image":tur,
      "price":"Rs.200",
      'name': 'tur'
    },
    {
      "image":urad,
      "price":"Rs.200",
      'name': 'urad'
    },
    {
      "image":ginger,
      "price":"Rs.200",
      'name': 'ginger'
    },
    {
      "image":moong,
      "price":"Rs.200",
      'name': 'moong'
    },
    {
      "image":jowar,
      "price":"Rs.200",
      'name': 'jowar'
    },
    {
      "image":chilli,
      "price":"Rs.200",
      'name': 'chilli'
    },
    {
      "image":rapeseed,
      "price":"Rs.200",
      'name': 'rapeseed'
    },
    {
      "image":redgram,
      "price":"Rs.200",
      'name': 'redgram'
    },
    {
      "image":groundnut,
      "price":"Rs.200",
      'name': 'groundnut'
    }
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
         appBar: AppBar(
           backgroundColor: Colors.white,
           title: Text("Latest Crops Price",style: TextStyle(color: Colors.green),),
           centerTitle: true,
          ),
        body: SingleChildScrollView(
            child: Wrap(
            runSpacing: 20,
            spacing: 20,
             direction: Axis.horizontal,
             alignment: WrapAlignment.start,
              children: [

                for(int i=0;i<cropsDetails.length;i++) _eachCropsCard(cropsDetails[i]['image'],cropsDetails[i]['name'], cropsDetails[i]['price'])
              
                // _eachCropsCard(wheat, "wheat","Rs 1000"),
                // _eachCropsCard(mustard,"mustard", "Rs 1000"),
                // _eachCropsCard(tur,"tur", "Rs 1000"),
                // _eachCropsCard(urad, "urad", "Rs 1000"),
                // _eachCropsCard(ginger,"ginger", "Rs 1000"),
                // _eachCropsCard(moong, "moong","Rs 1000"),
                // _eachCropsCard(jowar,"jowar", "Rs 1000"),
                // _eachCropsCard(chilli,"chilli" ,"Rs 1000"),
                // _eachCropsCard(bajra, "bajra","Rs 1000"),
                // _eachCropsCard(ragi, "ragi","Rs 1000"),
                // _eachCropsCard(rapeseed,"rapeseed", "Rs 1000"),
                // _eachCropsCard(redgram,"redgram", "Rs 1000"),
                // _eachCropsCard(groundnut,"groundnut", "Rs 1000"),
              ],
            
          ),
        ),
      ),
    );
  }

  Widget _eachCropsCard(String image,String name,String price){

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
            maxRadius: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text(price),
            
            Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}