import 'package:agro_farm/helper/imagehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart';

class CartView extends StatefulWidget {
   static const String idScreen="cartview";
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  // int _quantity=0;

  // List  cropsDetails= [

  //   {
  //     "image":wheat,
  //     "price":"Rs.200",
  //     'name': 'wheat',
  //     'quantity':0
  //   },
  //   {
  //     "image":mustard,
  //     "price":"Rs.200",
  //     'name': 'mustard',
  //     'quantity':0
  //   },
  //   {
  //     "image":tur,
  //     "price":"Rs.200",
  //     'name': 'tur',
  //     'quantity':0
  //   },
  //   {
  //     "image":urad,
  //     "price":"Rs.200",
  //     'name': 'urad',
  //     'quantity':0
  //   },
    
  // ];

  List cropsDetails=[];

  @override
  void initState() {
    super.initState();
    _readMyCart();
  }

  _readMyCart() async{
    Database database= await _openDB();
    List cartData=await database.query("usercart");
    setState(() {
      cropsDetails=cartData;
    });
    print(cartData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          
        body:cropsDetails.isEmpty? 
        Center(child: CircularProgressIndicator())
        :SingleChildScrollView(
            child: Column(
              children: [
                Container(
                // height: Get.height,
                child: Wrap(
                 direction: Axis.horizontal,
                 alignment: WrapAlignment.start,
                  children: [
                     
                  for(int i=0;i<cropsDetails.length;i++) _eachCropsCard(cropsDetails[i]['cropImageUrl'],cropsDetails[i]['cropname'],cropsDetails[i]['quantity'],i)
                  
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
                child: Text("Proceed to Buy",style: TextStyle(color: Colors.white,fontSize: 16),),
                color: Colors.green,
              ),
            )
              
              ]
            ),
        ),
      ),
    );
  }


  Widget _eachCropsCard(String image,String name, String quant,int i){

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
              cropDetails(name,image,quant,i),
              cropImage(image),
              
            ],
          ),
        ),
      ),
    );
  }

  Widget cropDetails(String name,String image,String quantity,int i){
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
                  onTap: () async {
                    // _quantity--;
                    
                      if(int.parse(cropsDetails[i]['quantity'])>0){
                         int res=int.parse(cropsDetails[i]['quantity'])-1;
                         Database database= await _openDB();
                         await database.update("usercart", {"quantity":res.toString()}, where: 'id=?', whereArgs: [cropsDetails[i]['id']]);
                         print("data updated");
                      }  
  
                  },
                  child: Text("-",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                SizedBox(width: 20,),
                Text(quantity.toString(),style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                SizedBox(width: 20,),
                GestureDetector(
                  onTap: (){
                    // _quantity--;
                    setState(() {
                      
                    int.parse(cropsDetails[i]['quantity']);
                    
                    });
                  },
                  child: Text("+",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Rs 200 per kg'),
              SizedBox(width: 20,),
              IconButton(
                tooltip: "Remove from Cart",
                icon: Icon(Icons.delete_forever_sharp,color: Colors.red,),
                onPressed: () async{
                  Database database= await _openDB();
                  database.delete("usercart",where: "id=?",whereArgs: [cropsDetails[i]['id']]);
                  print("data deleted");
                }
                )
            ],
          ),

          Text("Total: Rs "+ (int.parse(cropsDetails[i]['quantity'])*100).toString()),
          
        
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