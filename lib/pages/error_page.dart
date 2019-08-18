import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  var message = "fds";
  var route = "";

  ErrorPage({this.message, this.route});

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {

  @override
  void initState() {
    nextScreen();
    super.initState();
  }

  void nextScreen() async{
    Future.delayed(Duration(seconds: 2), () {
      if(widget.route == "myself") {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, widget.route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
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
