import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/planta_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var list = [
    PlantaItem(),
    PlantaItem(),
    PlantaItem(),
    PlantaItem(),
    PlantaItem(),
    PlantaItem(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFfbfbfb),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 20),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.menu, color: Color(0XFF11c180)),
                    ),
                    Text(
                      'Minhas Plantas',
                      style: TextStyle(color: Color(0XFF11c180)),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert, color: Color(0XFF11c180)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Text(
                  'Nivel 1',
                  style: TextStyle(color: Color(0XFF11c180), fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              LinearProgressIndicator(
                value: 30,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pontuação',
                    style: TextStyle(color: Color(0XFFD9AC59), fontSize: 14),
                  ),
                  Text(
                    '300 / 1500',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                child: TextField(
                    decoration: new InputDecoration(
                        suffixIcon: Icon(
                          Icons.mic,
                          color: Color(0XFF11c180),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0XFF11c180),
                        ),
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
                        labelText: '',
//              labelStyle: TextStyle(color: Color(0XFFD9D8D7)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ))),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return list[index];
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.maxFinite,
        height: 60,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 60,
              color: Color(0XFF11c180),
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        'assets/Drop.svg',
                        color: Colors.grey,
                      )),
                  Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        'assets/Drop.svg',
                        color: Colors.grey,
                      )),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'subscribe');
                    },
                    child: Container(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                          'assets/Drop.svg',
                          color: Colors.white,
                        )),
                  ),
                  Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        'assets/Drop.svg',
                        color: Colors.grey,
                      )),
                  Container(
                      width: 30,
                      height: 30,
                      child: SvgPicture.asset(
                        'assets/Drop.svg',
                        color: Colors.grey,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
