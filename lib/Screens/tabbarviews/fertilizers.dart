import 'package:agro_farm/helper/imagehelper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class FertilizerPage extends StatefulWidget {
   static const String idScreen="fertilizer";
  @override
  _FertilizerPageState createState() => _FertilizerPageState();
}

class _FertilizerPageState extends State<FertilizerPage> {

  // int _quantity=0;

  List  cropsDetails= [

     {
      "image":oraganicliquid,
      "price":"Rs.100",
      'name': 'Oraganicliquid',
      'quantity':0
    },

    {
      "image":bonemeal,
      "price":"Rs.100",
      'name': 'bonemeal',
      'quantity':0
    },
    {
      "image":compost,
      "price":"Rs.100",
      'name': 'compost',
      'quantity':0
    },
    {
      "image":manure,
      "price":"Rs.100",
      'name': 'manure',
      'quantity':0
    },
    {
      "image":rockphosphate,
      "price":"Rs.100",
      'name': 'rockphosphate',
      'quantity':0
    },
    {
      "image":cottonseed,
      "price":"Rs.100",
      'name': 'cottonseed',
      'quantity':0
    },
    {
      "image":alfalfa,
      "price":"Rs.100",
      'name': 'alfalfa',
      'quantity':0
    },
    {
      "image":bloodmeal,
      "price":"Rs.100",
      'name': 'bloodmeal',
      'quantity':0
    },
    {
      "image":feathermeal,
      "price":"Rs.100",
      'name': 'feathermeal',
      'quantity':0
    },

    {
      "image":liquidkelp,
      "price":"Rs.300",
      'name': 'liquidkelp',
      'quantity':0
    },

    
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          
        
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