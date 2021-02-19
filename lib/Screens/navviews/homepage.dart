import 'package:agro_farm/helper/imagehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

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
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () async{
              
            Database database= await _openDB();
            List result=await database.query("usercart");
            print(result);
          },
        ),
        appBar: searchBar.build(context),
        body: SingleChildScrollView(
            child: Wrap(
            runSpacing: 20,
            spacing: 20,
             direction: Axis.horizontal,
             alignment: WrapAlignment.start,
              children: [
                 
                for(int i=0;i<cropsDetails.length;i++) _eachCropsCard(cropsDetails[i]['image'],cropsDetails[i]['name'],cropsDetails[i]['price'],cropsDetails[i]['quantity'],i)
              
              ],
            
          ),
        ),
      ),
    );
  }


  Widget _eachCropsCard(String image,String name,String price, int quant, int i){

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
              cropDetails(name,price,image,quant,i),
              cropImage(image),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget cropDetails(String name,String price,String image,int quantity,int i){
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
              onPressed: () async{
                Database database= await _openDB();
                Map<String,dynamic> cartData ={
                "id":i,
                "cropname": name,
                "quantity": cropsDetails[i]['quantity'],  // use same name as column name
                "cropImageUrl": image,
                };
                await database.insert("usercart", cartData);
                Fluttertoast.showToast(msg: "Added to Cart!");
                cropsDetails[i]['quantity']=0;
                setState(() {
                  
                });
              },
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
                      if(cropsDetails[i]['quantity']>0){
                         cropsDetails[i]['quantity']--;
                      }
                     
                    });
                  },
                  child: Text("-",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                SizedBox(width: 20,),
                Text(quantity.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: (){
                    // _quantity--;
                    setState(() {
                      
                    cropsDetails[i]['quantity']++;
                      
                    
                    });
                  },
                  child: Text("+",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
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

Future<Database>_openDB() async{
    return openDatabase(await getDatabasesPath()+"/my_db.db");
}