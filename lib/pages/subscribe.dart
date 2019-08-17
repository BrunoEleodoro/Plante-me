import 'package:flutter/material.dart';

class SubscribeScreen extends StatefulWidget {
  @override
  _SubscribeScreenState createState() => _SubscribeScreenState();
}

//09bf7b
class _SubscribeScreenState extends State<SubscribeScreen> {
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
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20.0),
                            child: TextInputComponent(
                              label: 'Email',
                              obscureText: false,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 20.0),
                            child: TextInputComponent(
                              label: 'Senha',
                              obscureText: true,
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
                    onPressed: () {
                      Navigator.pushNamed(context, 'photo');
                    },
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

  TextInputComponent({this.label, this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
          obscureText: this.obscureText,
          decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide:
                    BorderSide(color: Color(0XFFD9D8D7), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
                borderSide:
                    BorderSide(color: Color(0XFFD9D8D7), width: 1.0),
              ),
              labelText: this.label,
//              labelStyle: TextStyle(color: Color(0XFFD9D8D7)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ))),
    );
  }
}
