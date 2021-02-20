

import 'package:agro_farm/Custom_Widgets/progressdialog.dart';
import 'package:agro_farm/helper/imagehelper.dart';
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

     if(temperature>=20.0454142 && temperature<=26.92995077 && humidity>=80.12267476 && humidity<=84.96907151 && ph>=5.005306977 && ph<=7.868474653 && rainfall>=182.5616319 && rainfall<=298.5601175 && soiltype==7){  
      print("Rice");
      await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Rice",rice); 
     }

    else if(temperature>=20.09136946 && temperature<=33.95209584 && humidity>=50.01891663 && humidity<=59.98962806 && ph>=6.002569182 && ph<=6.976582042 && rainfall>=76.73202842 && rainfall<=162.9129631 && soiltype==6){  
      await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Wheat",wheat); 
    }

                    
else if(temperature>=27.01470397 && temperature<=29.914544300000003 && humidity>=80.03499648 && humidity<=89.99615558 && ph>=6.2189238929999995 && ph<=7.199495367999999 && rainfall>=36.12042927 && rainfall<=59.87232071 && soiltype==8){  
  await Future.delayed(Duration(seconds: 5)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Mung Bean",moong); 
   }


else if(temperature>=21.00527346 && temperature<=28.97274022 && humidity>=55.00985779 && humidity<=64.98556519 && ph>=4.502596700000001 && ph<=4.9940762 && rainfall>=151.01298899999998 && rainfall<=249.4180906 && soiltype==6){  
   await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Tea",tea); 
   }


else if(temperature>=40.13607173 && temperature<=49.91822378 && humidity>=10.0340484 && humidity<=15.49100816 && ph>=5.615310267999999 && ph<=7.992859092000001 && rainfall>=35.19407768 && rainfall<=49.68143256 && soiltype==6){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("millet",millet); 
   }


else if(temperature>=18.04185513 && temperature<=26.54986394 && humidity>=55.28220433 && humidity<=74.82913698 && ph>=5.513697923 && ph<=6.995843776 && rainfall>=60.65171481 && rainfall<=109.7515385 && soiltype==10){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("maize",maize); 
   }


else if(temperature>=18.06486101 && temperature<=29.94413861 && humidity>=60.09116626 && humidity<=69.92375891 && ph>=5.91645379 && ph<=7.841496029 && rainfall>=35.03484812 && rainfall<=54.93937710000001 && soiltype==8){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Lentil",lentil); 
   }


else if(temperature>=23.09433785 && temperature<=26.98582182 && humidity>=70.88259632 && humidity<=89.89106506 && ph>=6.002524871 && ph<=7.488014403999999 && rainfall>=150.2355238 && rainfall<=199.83629130000003 && soiltype==11){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Jute",jute); 
   }


else if(temperature>=23.05951896 && temperature<=27.92374437 && humidity>=50.04557009 && humidity<=69.94807345 && ph>=6.020947179 && ph<=7.493191968 && rainfall>=115.1564012 && rainfall<=199.4735636 && soiltype==8){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Coffee",coffee); 
   }


else if(temperature>=22.00085141 && temperature<=25.99237426 && humidity>=75.00539324 && humidity<=84.87668973 && ph>=5.801047545 && ph<=7.994679507000001 && rainfall>=60.65381719 && rainfall<=99.93100821 && soiltype==8){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Cotton",cottonseed); 
   }


else if(temperature>=30.01930633 && temperature<=33.94512460000001 && humidity>=55.26434644 && humidity<=74.97475129 && ph>=6.010802677999999 && ph<=6.468806012999999 && rainfall>=62.9183321 && rainfall<=149.0994209 && soiltype==8){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Ground Nut",groundnut); 
   }


else if(temperature>=16.02173044 && temperature<=18.99235974 && humidity>=13.00243832 && humidity<=13.99818474 && ph>=5.826656734 && ph<=6.989783702 && rainfall>=45.15647705 && rainfall<=54.85580308 && soiltype==8){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Peas",peas); 
   }


else if(temperature>=20.09136946 && temperature<=33.95209584 && humidity>=60.04305978 && humidity<=79.88797861 && ph>=4.521950082 && ph<=5.998318942 && rainfall>=200.0596627 && rainfall<=397.3153799 && soiltype==6){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Rubber",rubber); 
   }


else if(temperature>=25.08600918 && temperature<=29.95544134 && humidity>=75.09520431 && humidity<=84.94118326 && ph>=5.0318861660000005 && ph<=8.489422864 && rainfall>=100.03309420000001 && rainfall<=174.9108513 && soiltype==8){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Sugarcane",sugarcane); 
   }


else if(temperature>=18.50460352 && temperature<=28.22598038 && humidity>=60.11707239999999 && humidity<=69.99596284 && ph>=5.801432885 && ph<=6.199742118 && rainfall>=75.0138315 && rainfall<=84.90268794 && soiltype==7){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Tobacco",tobacco); 
   }


else if(temperature>=15.33042636 && temperature<=24.92360104 && humidity>=18.09224048 && humidity<=24.96969858 && ph>=5.502999119 && ph<=5.99812453 && rainfall>=60.27552528 && rainfall<=149.7441028 && soiltype==2){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Kidney Beans",kidneybeans); 
   }


else if(temperature>=24.01825377 && temperature<=31.99928579 && humidity>=40.00933429 && humidity<=64.95585424 && ph>=3.5047523139999996 && ph<=9.93509073 && rainfall>=30.92014047 && rainfall<=74.44330654 && soiltype==2){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Moth Beans",mothbeans); 
   }


else if(temperature>=25.00872392 && temperature<=29.869083399999997 && humidity>=90.01734526 && humidity<=99.98187601 && ph>=5.50158009 && ph<=6.470465614 && rainfall>=131.09000759999998 && rainfall<=225.63236559999999 && soiltype==7){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Coconut",coconut); 
   }


else if(temperature>=25.09737391 && temperature<=34.9466155 && humidity>=60.06534859 && humidity<=69.96100028 && ph>=6.500144962 && ph<=7.775306272000001 && rainfall>=60.41790253 && rainfall<=74.91559514 && soiltype==6){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Black gram",blackgram); 
   }


else if(temperature>=50.05296256 && temperature<=54.98675978 && humidity>=40.21677505 && humidity<=64.80974774 && ph>=5.0172808689999995 && ph<=7.490025022999999 && rainfall>=50.34963363 && rainfall<=174.6110193 && soiltype==3){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Adzuki Beans",adzukibeans); 
   }


else if(temperature>=18.31910448 && temperature<=36.97794384 && humidity>=30.40046769 && humidity<=69.69141302 && ph>=4.548202098 && ph<=7.4454448829999995 && rainfall>=90.05422663 && rainfall<=198.8298806 && soiltype==8){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Pigeon Peas",pigeonpeas); 
   }


else if(temperature>=17.02498456 && temperature<=20.99502153 && humidity>=14.25803981 && humidity<=19.96978871 && ph>=5.988992796000001 && ph<=8.868741443 && rainfall>=65.11365631 && rainfall<=94.78189594 && soiltype==10){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("Chickpea",chickpea); 
   }


else if(temperature>=8.825674745 && temperature<=41.94865736 && humidity>=80.01639435 && humidity<=83.98351748 && ph>=5.510924848999999 && ph<=6.499604931 && rainfall>=65.01095312 && rainfall<=74.91506217 && soiltype==8){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("grapes",grape); 
   }


else if(temperature>=21.0365275 && temperature<=23.99686172 && humidity>=90.02575116 && humidity<=94.92048112 && ph>=5.514253142 && ph<=6.499226821000001 && rainfall>=100.1173443 && rainfall<=124.9831618 && soiltype==6){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("apple",apple); 
   }


else if(temperature>=27.00315545 && temperature<=35.99009679 && humidity>=45.02236377 && humidity<=54.9640534 && ph>=4.507523551 && ph<=6.9674177660000005 && rainfall>=89.29147581 && rainfall<=100.8124659 && soiltype==2){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("mango",mango); 
   }


else if(temperature>=27.02415146 && temperature<=29.94349168 && humidity>=90.01506395 && humidity<=94.96218673 && ph>=6.002927293 && ph<=6.781050372999999 && rainfall>=20.21126747 && rainfall<=29.86681385 && soiltype==8){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("muskmelon",muskmelon); 
   }


else if(temperature>=10.01081312 && temperature<=34.90665289 && humidity>=90.00621688 && humidity<=94.96419851 && ph>=6.010391864 && ph<=7.9958489770000005 && rainfall>=100.1737964 && rainfall<=119.69465770000001 && soiltype==9){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("orange",orange); 
   }


else if(temperature>=23.012401800000003 && temperature<=43.67549305 && humidity>=90.03863107 && humidity<=94.94482086 && ph>=6.501521192 && ph<=6.993473247000001 && rainfall>=40.35153141 && rainfall<=248.85929860000002 && soiltype==8){  
 await Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("papaya",papaya); 
   }


else if(temperature>=18.07132963 && temperature<=24.96273236 && humidity>=85.12912161 && humidity<=94.99897537 && ph>=5.561851831 && ph<=7.199504273 && rainfall>=102.51847590000001 && rainfall<=112.47509409999999 && soiltype==7){  
 await Future.delayed(Duration(seconds: 8)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("pomegranate",pomegranate); 
   }


else if(temperature>=24.04355803 && temperature<=26.98603693 && humidity>=80.02621335 && humidity<=89.98405233 && ph>=6.000975617000001 && ph<=6.956508826 && rainfall>=40.12650421 && rainfall<=59.75980023 && soiltype==8){  
 await Future.delayed(Duration(seconds: 8)).then((value) {
      Navigator.pop(context);
     });

     _bottomSheet("watermelon",watermelon); 
   }

   else{
     Fluttertoast.showToast(msg: "Enter valid arguments");
   }

}

  void _bottomSheet(String cropName, String cropImageUrl){
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
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text("Suggested Crop",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(cropName,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(cropImageUrl,height: 150,width: Get.width*.7))
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
      );
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