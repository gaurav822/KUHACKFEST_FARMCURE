

import 'package:agro_farm/Custom_Widgets/progressdialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CropsPage extends StatefulWidget {
  @override
  _CropsPageState createState() => _CropsPageState();
}

class _CropsPageState extends State<CropsPage> {
  TextEditingController humidityController= TextEditingController();
  TextEditingController soiltypeController= TextEditingController();
  TextEditingController phController= TextEditingController();
  TextEditingController temperatureController= TextEditingController();
  TextEditingController rainfallController= TextEditingController();
  FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        backgroundColor: Colors.white,
        
        body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  
                  child: Image.asset("images/cropsback.jpg",fit: BoxFit.cover,height: Get.height,),
                ),
                Container(
                // color: Colors.red,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text("Enter details to Cultivate Best Crops",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.green.shade700),),
                    SizedBox(
                      height: 20,
                    ),
                    _inputDataSetForm("Humidity",humidityController),
                    _inputDataSetForm("Soil Type",soiltypeController),
                    _inputDataSetForm("Enter Ph Value",phController),
                    _inputDataSetForm("Enter temperature",temperatureController),
                    _inputDataSetForm("rainfall",rainfallController),

                    SizedBox(
                      height: 20,
                    ),

                    _findBestCropButton()
                  ],
                ),
              ),
          ),
          
          ]
            ),
        ),
      ),
    );
  }

  Widget _findBestCropButton(){
    return MaterialButton(
      minWidth: 200,
      height: 40,
      color: Colors.green,
      child: Text("Find Crop",style: TextStyle(color: Colors.white,fontSize: 20),),
      onPressed: _findBestCrops,
    );
  }

  _findBestCrops() async{


    if(humidityController.text.isEmpty){
      
     showToast(toastmsg: "Please enter humidity");
    }

    else if(soiltypeController.text.isEmpty){
      showToast(toastmsg: "Please enter soil type");
    }

    else if(phController.text.isEmpty){
      showToast(toastmsg: "Please enter Ph value");
    }
  

    else if(temperatureController.text.isEmpty){
      showToast(toastmsg: "Please enter temperature");
    }

    else if(rainfallController.text.isEmpty){
      showToast(toastmsg: "Please enter rainfall");
    }

    else{
      showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context)
      {
        return ProgressDialog(message:"Finding best Crop for you...");
      }
    );

    _findOptimalCrop();


   }
    
  }

  _findOptimalCrop() async{
     double temperature = double.parse(temperatureController.text);
     double humidity = double.parse(humidityController.text);
     double ph = double.parse(phController.text);
     double rainfall = double.parse(rainfallController.text);
     int soiltype = int.parse(soiltypeController.text);

     if(temperature>=20.0454142 && temperature<=26.80079604){
      print("Rice");
      await Future.delayed(Duration(seconds: 8)).then((value) {
      Navigator.pop(context);
    });

      showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Suggested Crop",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Rice",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset("images/rice.jpg",height: 200,width: 300,))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
      );
     }
  }

  Widget _inputDataSetForm(String textHint,TextEditingController textEditingController){

    OutlineInputBorder outlineInputBorder=OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      
      borderSide: BorderSide(
        color: Colors.green,
        width: 3
      )
    );

    return Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: textHint,
          hintStyle: TextStyle(color: Colors.green),
          border: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          enabledBorder: outlineInputBorder
        ),
      ),
    );
  }


  showToast({String toastmsg}) {
    Widget toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
            Icon(Icons.error),
            SizedBox(
            width: 12.0,
            ),
            Text(toastmsg,style: TextStyle(color: Colors.white),),
        ],
        ),
    );


    fToast.showToast(
        child: toast,
        gravity: ToastGravity.BOTTOM,
        toastDuration: Duration(seconds: 3),
    );
  
}


}