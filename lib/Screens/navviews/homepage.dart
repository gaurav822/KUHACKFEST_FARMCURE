import 'package:agro_farm/helper/imagehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
   static const String idScreen="home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // int _quantity=0;

  List  cropsDetails= [

    {
      "image":wheat,
      "price":"Rs.200",
      'name': 'wheat',
      'quantity':0
    },
    {
      "image":mustard,
      "price":"Rs.200",
      'name': 'mustard',
      'quantity':0
    },
    {
      "image":tur,
      "price":"Rs.200",
      'name': 'tur',
      'quantity':0
    },
    {
      "image":urad,
      "price":"Rs.200",
      'name': 'urad',
      'quantity':0
    },
    {
      "image":ginger,
      "price":"Rs.200",
      'name': 'ginger',
      'quantity':0
    },
    {
      "image":moong,
      "price":"Rs.200",
      'name': 'moong',
      'quantity':0
    },
    {
      "image":jowar,
      "price":"Rs.200",
      'name': 'jowar',
      'quantity':0
    },
    {
      "image":chilli,
      "price":"Rs.200",
      'name': 'chilli',
      'quantity':0
    },
    {
      "image":rapeseed,
      "price":"Rs.200",
      'name': 'rapeseed',
      'quantity':0
    },
    {
      "image":redgram,
      "price":"Rs.200",
      'name': 'redgram',
      'quantity':0
    },
    {
      "image":groundnut,
      "price":"Rs.200",
      'name': 'groundnut',
      'quantity':0
    }
  ];

  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('Welcome Farmer'),
      centerTitle: true,
      actions: [searchBar.getSearchAction(context)]
    );
  } 

  _HomePageState() {
    searchBar = new SearchBar(
      inBar: false,
      setState: setState,
      onSubmitted: print,
      buildDefaultAppBar: buildAppBar
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        appBar: searchBar.build(context),
        body: SingleChildScrollView(
            child: Wrap(
            runSpacing: 20,
            spacing: 20,
             direction: Axis.horizontal,
             alignment: WrapAlignment.start,
              children: [
                 
                for(int i=0;i<cropsDetails.length;i++) _eachCropsCard(cropsDetails[i]['image'],cropsDetails[i]['name'],cropsDetails[i]['price'])
              
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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade300
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              cropDetails(name,price,image),
              cropImage(image)
            ],
          ),
        ),
      ),
    );
  }

  Widget cropDetails(String name,String price,String image){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      
      children: [
        
        Text(name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
        Text(price+" per kg"),
        
                    ClipRRect(
            borderRadius: BorderRadius.circular(10),
                    child: FlatButton(
              color: Colors.green,
              child: Text("Add to Cart",style: TextStyle(color: Colors.white),),
              onPressed: (){},
            ),
          ),

          Container(
            
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Text("Quantity"),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: (){
                    // _quantity--;
                    setState(() {
                      
                    });
                  },
                  child: Text("-",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                SizedBox(width: 20,),
                Text("0",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(width: 20,),
                Text("+",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ],
            ),
          )
          
        
      ],
    );
  }

  Widget cropImage(String image){
    return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
        image,
        fit: BoxFit.cover,
        height: Get.height,
        width: 200,
        
        ),
    );
  }
}