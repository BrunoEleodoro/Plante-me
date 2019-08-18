import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Color(0XFF04BF7B),
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height - 400,
        ),
        Container(
          color: Colors.white,
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height,
        ),
      ],
    );
  }
}

class Dot extends StatelessWidget {
  var color;

  Dot({this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.all(Radius.circular(25))),
    );
  }
}

class Page extends StatelessWidget {
  var title;
  var assetName;
  var subtitle;
  var description;

  Page({this.title, this.assetName, this.subtitle, this.description});

  @override
  Widget build(BuildContext context) {
    final Widget svgIcon = new SvgPicture.asset(
      assetName,
    );

    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text(
            this.title,
            style: TextStyle(
                color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 60,
          ),
          svgIcon,
          SizedBox(
            height: 60,
          ),
          Text(
            this.subtitle,
            style: TextStyle(
              color: Color(0XFF04BF7B),
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            this.description,
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _OnboardingPageState extends State<OnboardingPage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Background(),
            Column(
              children: <Widget>[
                Container(
                  height: 600,
                  child: PageView(
                    onPageChanged: (value)  {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                    children: <Widget>[
                      Page(
                        title: 'Água',
                        assetName: 'assets/onboarding1.svg',
                        subtitle:
                            'Um pouco de água por dia\né tudo que preciso!',
                        description:
                            'Regue sua planta para que ela não fique\ndoente, aliás água faz muito bem a saúde.',
                      ),
                      Page(
                        title: 'Sol',
                        assetName: 'assets/onboarding2.svg',
                        subtitle:
                            'Ah, o Sol, nada como uma\nboa fotossíntese!',
                        description:
                            'O Sol é um recurso natural importantíssimo\nno crescimento de sua planta, não se\nesqueça disso.',
                      ),
                      Page(
                        title: 'Adubo',
                        assetName: 'assets/onboarding3.svg',
                        subtitle:
                        'Reformar para crescer,\nesse é o lema!',
                        description:
                        'Adube e troque a terra de sua planta\nperiodicamente, dessa maneira ela crescerá\nforte e saudável.',
                      ),
                      Page(
                        title: 'Plant.me',
                        assetName: 'assets/onboarding4.svg',
                        subtitle:
                        'Espero que nossa relação\ndure um bom tempo!',
                        description:
                        '',
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Dot(
                      color: (selectedIndex == 0) ? Color(0XFF04BF7B) : Color(0XFFD9D8D7),
                    ),
                    Dot(
                      color: (selectedIndex == 1) ? Color(0XFF04BF7B) : Color(0XFFD9D8D7),
                    ),
                    Dot(
                      color: (selectedIndex == 2) ? Color(0XFF04BF7B) : Color(0XFFD9D8D7),
                    ),
                    Dot(
                      color: (selectedIndex == 3) ? Color(0XFF04BF7B) : Color(0XFFD9D8D7),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
