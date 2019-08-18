import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {
  var message = "fds";
  var route = "";

  SuccessPage({this.message, this.route});

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {

  @override
  void initState() {
    nextScreen();
    super.initState();
  }

  void nextScreen() async{
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, widget.route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF359ecf),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.message,
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            Container(
              child: Icon(Icons.check_circle_outline, color: Colors.white,size: 100,),
            ),
          ],
        ),
      ),
    );
  }
}
