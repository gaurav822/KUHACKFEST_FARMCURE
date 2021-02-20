
import 'package:agro_farm/Custom_Widgets/progressdialog.dart';
import 'package:agro_farm/Screens/navviewpage.dart';
import 'package:agro_farm/utils/bubble_indication_painter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// import 'package:project1/style/theme.dart' as theme;

class LoginPage extends StatefulWidget {
  
  LoginPage({Key key}) : super(key: key);

  static const String idScreen="login";

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {

    FirebaseAuth firebaseAuth= FirebaseAuth.instance;

    FirebaseFirestore firebaseFirestore= FirebaseFirestore.instance;
    

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodePhone = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
   TextEditingController signupPhoneController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();

  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: new Scaffold(
          resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        
        body: NotificationListener<OverscrollIndicatorNotification>(
          // ignore: missing_return
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: SingleChildScrollView(
                child:  Container(
                    
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height >= 775.0
                        ? MediaQuery.of(context).size.height
                        : 775.0,
                    
                    child: Stack(
                      children: [
                        Container(
                          
                          child: Image.asset("images/back.jpg",height: Get.height,fit: BoxFit.cover,),
                        ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 75.0),
                            
                              child:  Container(
                                  decoration: BoxDecoration(),
                                  height: 150,
                                  width: 150,
                                     child: CircleAvatar(
                                      backgroundImage: AssetImage("images/farmer.jpg")),
                                  )),
                      
                        
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: _buildMenuBar(context),
                          ),
                          Expanded(
                            flex: 2,
                            child: PageView(
                              controller: _pageController,
                              onPageChanged: (i) {
                                if (i == 0) {
                                  setState(() {
                                    right = Colors.white;
                                    left = Colors.black;
                                  });
                                } else if (i == 1) {
                                  setState(() {
                                    right = Colors.black;
                                    left = Colors.white;
                                  });
                                }
                              },
                              children: <Widget>[
                                new ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: _buildSignIn(context),
                                ),
                                new ConstrainedBox(
                                  constraints: const BoxConstraints.expand(),
                                  child: _buildSignUp(context),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      ]
                    ),
                  ),
                ),
              ),
        ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    myFocusNodePhone.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }


  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Color(0x552B2B2B),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Existing",
                  style: TextStyle(
                      color: left,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
            Container(height: 33.0, width: 1.0, color: Colors.white),
            Expanded(
              child: FlatButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onPressed: _onSignUpButtonPress,
                child: Text(
                  "New",
                  style: TextStyle(
                      color: right,
                      fontSize: 16.0,
                      fontFamily: "WorkSansSemiBold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                shadowColor: Colors.white,
                color: Colors.grey.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: Colors.green,
                              size: 22.0,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.green,
                            ),
                            hintText: "Password",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 170.0, bottom: 60),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    // BoxShadow(
                    //   color: Colors.white,
                    //   offset: Offset(1.0, 6.0),
                    //   blurRadius: 20.0,
                    // ),
                    // BoxShadow(
                    //   color: Colours.loginGradientEnd,
                    //   offset: Offset(1.0, 6.0),
                    //   blurRadius: 20.0,
                    // ),
                  ],
                  
                ),
                child: MaterialButton(
                    // highlightColor: Colors.transparent,
                    // splashColor: Colours.loginGradientEnd,
                    color: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () {

                      _loginAuth(context);
                      // showInSnackBar("Login button pressed");
                    }
                        
                  ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Container(
              width: 175,
              height: 40,
              color: Colors.white,
              child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.green,
                        fontSize: 16.0,
                        // fontWeight: FontWeight.bold,
                        fontFamily: "WorkSansMedium"),
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white10,
                          Colors.white,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    "Or",
                    style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16.0,
                        fontFamily: "WorkSansMedium"),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white10,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),
    
        ],
      ),
    );
  }

  Future<void> _loginAuth(BuildContext context) async{
    
    if(loginEmailController.text.isEmpty || !loginEmailController.text.isEmail){
      Fluttertoast.showToast(msg: "Enter the correct email address..",backgroundColor: Colors.red);
    }
    else if(loginPasswordController.text.isEmpty){
      Fluttertoast.showToast(msg: "Password cannot be empty!",backgroundColor: Colors.red);
    }
    else if(loginPasswordController.text.length<8){
      Fluttertoast.showToast(msg: "Invalid Password",backgroundColor: Colors.red);
    }

    else{
      await _loginFarmerAuth(context); 
    }
     
  }

  Future<void> _loginFarmerAuth(BuildContext context) async{

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context)
      {
        return ProgressDialog(message:"Logging in...");
      }

    );

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: loginEmailController.text,
      password: loginPasswordController.text
     );
     Navigator.pop(context);
     Fluttertoast.showToast(msg: "Login Successful",backgroundColor: Colors.blue);
     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> NavViewPage()), (route) => false);

    } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "No user found for that email",backgroundColor: Colors.red);
        print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Wrong password provided for that user.",backgroundColor: Colors.red);
        print('Wrong password provided for that user.');
    }
  }
    
    
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.grey.shade200,
                shadowColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 500.0,
                  child: SingleChildScrollView(
                      child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextField(
                            focusNode: myFocusNodeName,
                            controller: signupNameController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.userAlt,
                                color: Colors.green,
                              ),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        

                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextField(
                            focusNode: myFocusNodePhone,
                            controller: signupPhoneController,
                            keyboardType: TextInputType.phone,
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.phoneAlt,
                                color: Colors.green,
                              ),
                              hintText: "Phone number",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),

                        
                        


                        
                        
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextField(
                            focusNode: myFocusNodeEmail,
                            controller: signupEmailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.email,
                                color: Colors.green,
                              ),
                              hintText: "Email Address",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextField(
                            focusNode: myFocusNodePassword,
                            controller: signupPasswordController,
                            obscureText: _obscureTextSignup,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.green,
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignup,
                                child: Icon(
                                  _obscureTextSignup
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextField(
                            controller: signupConfirmPasswordController,
                            obscureText: _obscureTextSignupConfirm,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.green,
                              ),
                              hintText: "Confirmation",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold", fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignupConfirm,
                                child: Icon(
                                  _obscureTextSignupConfirm
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  size: 15.0,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: Get.height/1.8),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    // BoxShadow(
                    //   color: Colors.white,
                    //   offset: Offset(1.0, 6.0),
                    //   spreadRadius: 1,
                    //   blurRadius: 15,
                    // ),
                    // BoxShadow(
                    //   color: Colours.loginGradientEnd,
                    //   offset: Offset(1.0, 6.0),
                    //   blurRadius: 20.0,
                    // ),
                  ],
                 
                ),
                child: MaterialButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: _signUpFarmer
                    )
              ),
              
            ], 
          ),
        ],
      ),
    );
  }

  _signUpFarmer() async{
      if(signupNameController.text.isEmpty){
        Fluttertoast.showToast(msg: "Name cannot be empty!",backgroundColor: Colors.red);
      }

      else if(signupPhoneController.text.isEmpty){
        Fluttertoast.showToast(msg: "Phone cannot be empty!",backgroundColor: Colors.red);
      }

      else if(signupEmailController.text.isEmpty){
        Fluttertoast.showToast(msg: "Email cannot be empty!",backgroundColor: Colors.red);
      }

      else if(signupPasswordController.text.isEmpty){
        Fluttertoast.showToast(msg: "Password cannot be empty!",backgroundColor: Colors.red);
      }

      else if(signupConfirmPasswordController.text.isEmpty || signupPasswordController.text!=signupConfirmPasswordController.text){
        Fluttertoast.showToast(msg: "Re-enter the password!",backgroundColor: Colors.red);
      }

      else{

      showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context)
      {
        return ProgressDialog(message:"Registering...Please Wait");
      }
      );
      await _registerFarmerFirebase();

      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "Registration Successful!",backgroundColor: Colors.green);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginPage()));
    }
  }

  Future<void> _registerFarmerFirebase()async{
    Map<String,dynamic> farmerData={
      "email":signupEmailController.text,
      "name":signupNameController.text,
      "phone number":signupPhoneController.text,
    };
    await firebaseAuth.createUserWithEmailAndPassword(
      email: signupEmailController.text.toString(),
      
      password: signupPasswordController.text.toString(), 
    );
    await firebaseFirestore.collection("Farmers").doc(signupEmailController.text).set(farmerData);
  }

  // ignore: unused_element
  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  // ignore: unused_element
  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }
}
