import 'package:agro_farm/helper/imagehelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class CartView extends StatefulWidget {
   static const String idScreen="cartview";
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
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
    
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          
        body: SingleChildScrollView(
            child: Column(
                          children: [Container(
                height: Get.height,
                child: Wrap(
                 direction: Axis.horizontal,
                 alignment: WrapAlignment.start,
                  children: [
                     
                  for(int i=0;i<cropsDetails.length;i++) _eachCropsCard(cropsDetails[i]['image'],cropsDetails[i]['name'],cropsDetails[i]['price'],cropsDetails[i]['quantity'],i)
                  
                  ],
                
          ),
              ),
            SizedBox(
              height: 20,
            ),
            Text("Total Price: Rs.500",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                height: 50,
                minWidth: 100,
                onPressed: (){},
                child: Text("Proceed for Payment",style: TextStyle(color: Colors.white,fontSize: 16),),
                color: Colors.green,
              ),
            )
              
              ]
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
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Total : Rs 200'),
              SizedBox(width: 20,),
              IconButton(
                tooltip: "Remove from Cart",
                icon: Icon(Icons.delete_forever_sharp,color: Colors.red,),
                onPressed: null
                )
            ],
          ),
          
        
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