import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SubscribeScreen extends StatefulWidget {
  @override
  _SubscribeScreenState createState() => _SubscribeScreenState();
}

//09bf7b
class _SubscribeScreenState extends State<SubscribeScreen> {
  var isLoading = false;
  TextEditingController controller_nome = new TextEditingController();
  TextEditingController controller_email = new TextEditingController();
  TextEditingController controller_senha = new TextEditingController();
  SharedPreferences prefs;

  void cadastrar() async {
    setState(() {
      isLoading = true;
    });
    var password = utf8.encode(controller_senha.text);
    var digest1 = sha256.convert(password);

    var url = 'https://plantemenode.herokuapp.com/user/signup';
    var response = await http.post(url, body: {
      'name': controller_nome.text,
      'email': controller_email.text,
      'password': digest1.toString()
    });
    var json = jsonDecode(response.body);

    prefs.setString("token", json['token']);

    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, 'onboarding');
  }

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    prefs = await SharedPreferences.getInstance();
  }

  /*
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf5f5f5),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Stack(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xFF09bf7b),
                        ),
                      ),
                      Container(
                        height: 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Plant.me',
                              style: TextStyle(
                                  color: Color(0xFF09bf7b),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Content
                (this.isLoading) ? LinearProgressIndicator() : Text(''),
                Container(
                  width: double.maxFinite,
                  height: 500,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 30, bottom: 20),
                            child: Text('Criar uma conta',
                                style: TextStyle(fontSize: 25)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20.0),
                            child: TextInputComponent(
                              label: 'Nome completo',
                              obscureText: false,
                              controller: controller_nome,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20.0),
                            child: TextInputComponent(
                              label: 'Email',
                              obscureText: false,
                              controller: controller_email,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20.0),
                            child: TextInputComponent(
                              label: 'Senha',
                              obscureText: true,
                              controller: controller_senha,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20.0),
                            child: TextInputComponent(
                              label: 'Confirmar senha',
                              obscureText: true,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Text(
                              'Criando uma conta você aceita nossos\nTermos de Serviço e Politica de Privacidade',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(left: 5, top: 10, right: 5),
                  width: double.maxFinite,
                  child: MaterialButton(
                    height: 50,
                    onPressed: cadastrar,
                    color: Colors.green,
                    child: Text(
                      'CONTINUAR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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
