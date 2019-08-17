import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plante Me',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FirstPage(),
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
        child: Text(this._token),
      ),
    );
  }
}


