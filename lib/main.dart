import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:plante_me/pages/home/home.dart';
import 'package:plante_me/pages/login.dart';
import 'package:plante_me/pages/onboarding/onboarding.dart';
import 'dart:io';
import 'pages/subscribe.dart';
import 'pages/take_photo.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plante Me',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
      routes: {
        // When navigating to the "/second" route, build the SecondScreen widget.
        'subscribe': (context) => SubscribeScreen(),
        'photo' : (context) => TakePhoto(),
        'onboarding' : (context) => OnboardingPage(),
        'home' : (context) => HomePage(),
      },
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var _token = "";
  @override
  void initState() {
    _firebaseMessaging.getToken().then((token){
      print("Firebase token " + token);
      setState(() {
        _token = token;
      });
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {},
      onResume: (Map<String, dynamic> message) async {},
      onLaunch: (Map<String, dynamic> message) async {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: MaterialButton(child: Text('Subscribe'),
            onPressed: (){
          Navigator.pushNamed(context, 'subscribe');
        }),
      ),
    );
  }
}


