import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../success_page.dart';

class PlantaItem extends StatefulWidget {
  var apelido;
  var nome;
  var sol;
  var adubagem;
  var regadas;

  PlantaItem({this.apelido, this.nome, this.sol, this.adubagem, this.regadas});
  @override
  _PlantaItemState createState() => _PlantaItemState();
}

class _PlantaItemState extends State<PlantaItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 35,
                        child: Image.network(
                            'https://multimidia.gazetadopovo.com.br/media/info/2017/201710/plantas-problemas-saudavel.png'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        widget.apelido,
                        style:
                            TextStyle(color: Color(0XFF09bf7b), fontSize: 22),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.nome,
                        style:
                            TextStyle(color: Color(0XFFD9AC59), fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuccessPage(message: 'Filomena regada!',route: 'home',),
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(width: 30,height: 30,child:SvgPicture.asset('assets/Drop.svg')),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.regadas,
                              style: TextStyle(
                                  color: Color(0XFF09bf7b),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Regadas',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(width: 30,height: 30,child:SvgPicture.asset('assets/Sun.svg')),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.sol,
                            style: TextStyle(
                                color: Color(0XFF09bf7b),
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Raios de Sol',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(width: 30,height: 30,child:SvgPicture.asset('assets/Soil.svg')),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.adubagem,
                              style: TextStyle(
                                  color: Color(0XFF09bf7b),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Adubagem',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ))
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
