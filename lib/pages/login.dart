import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controller_email = new TextEditingController();
  TextEditingController controller_password = new TextEditingController();

  var isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });
    var password = utf8.encode(controller_password.text);
    var digest1 = sha256.convert(password);

    var url = 'https://plantemenode.herokuapp.com/user/login';
    var response = await http.post(url,
        body: {'email': controller_email.text, 'password': digest1.toString()});
    var json = jsonDecode(response.body);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", json['token']);

    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, 'onboarding');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF00c474),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 120,
            ),
            Container(
              width: double.maxFinite,
              child: Text(
                'Plant.me',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.maxFinite,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        (this.isLoading) ? LinearProgressIndicator() : Text(''),
                        Container(
                          width: double.maxFinite,
                          child: Text(
                            'Bem-vindo',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextInputComponent(
                          label: 'E-mail',
                          obscureText: false,
                          controller: controller_email,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextInputComponent(
                          label: 'Senha',
                          obscureText: true,
                          controller: controller_password,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.maxFinite,
                          child: Text(
                            'Esquece a senha?',
                            style: TextStyle(
                              color: Color(0XFFD9AC59),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.maxFinite,
                          child: MaterialButton(
                            height: 50,
                            color: Color(0XFFD9AC59),
                            onPressed: () {
                              if (!isLoading) {
                                login();
                              }

//                              Navigator.pushNamed(context, 'onboarding');
                            },
                            child: Text(
                              'ENTRAR',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Não tem uma conta ainda?',
                              style: TextStyle(),
                            ),
                            Text(
                              ' Registre-se!',
                              style: TextStyle(color: Color(0XFFD9AC59)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.maxFinite,
                          child: MaterialButton(
                            height: 50,
                            color: Colors.green,
                            onPressed: () {
                              Navigator.pushNamed(context, 'subscribe');
                            },
                            child: Text(
                              'CADASTRAR',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextInputComponent extends StatelessWidget {
  var label = "";
  var obscureText = false;
  var controller;

  TextInputComponent({this.label, this.obscureText, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
          controller: controller,
          obscureText: this.obscureText,
          decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(color: Color(0XFFD9D8D7), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide: BorderSide(color: Color(0XFFD9D8D7), width: 1.0),
              ),
              labelText: this.label,
//              labelStyle: TextStyle(color: Color(0XFFD9D8D7)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ))),
    );
  }
}
