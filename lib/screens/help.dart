import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURLBrowser() async {
  const url =
      'https://lamiabensalem.github.io/uppie-showcase/?fbclid=IwAR3o0D7M7gTe2SGbjMckDuvYPQPZtc5k9MJ9fBpTYhD7W0pkZQ8UekSGc0c';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURLBrowser1() async {
  const url = 'https://www.facebook.com/Uppie-101414702238267';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURLBrowser2() async {
  const url = 'https://www.instagram.com/uppie_06/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURLBrowser3() async {
  const url = 'mailto:Uppie06@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg_help.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () => {Navigator.pop(context)},
                          child: Image(
                            image: AssetImage('images/x.png'),
                            height: 0.0372 * screenHeight,
                            width: 0.0694 * screenWidth,
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(65, 20, 0, 0),
                      child: Stack(children: [
                        Image(
                          image: AssetImage('images/rec_help.png'),
                          width: 0.4166 * screenWidth,
                        ),
                        Positioned(
                          left: 0.1388 * screenWidth,
                          child: BorderedText(
                            strokeColor: Color.fromARGB(255, 236, 244, 244),
                            strokeWidth: 3,
                            child: Text(
                              'Aide',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontFamily: 'Boogaloo',
                                fontSize: 0.0446 * screenHeight,
                                color: Color.fromARGB(255, 110, 200, 235),
                                shadows: [
                                  Shadow(offset: Offset(0, 0)),
                                  Shadow(offset: Offset(0, 0)),
                                  Shadow(offset: Offset(0, 0)),
                                  Shadow(color: Colors.grey),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]),
                    )
                  ],
                ),
                SizedBox(height: 0.05208 * screenHeight),
                Row(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: BorderedText(
                      strokeColor: Color.fromARGB(255, 236, 244, 244),
                      strokeWidth: 3,
                      child: Text(
                        'Informations pour les parents :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontFamily: 'Boogaloo',
                          fontSize: 0.0694 * screenWidth,
                          color: Color.fromARGB(255, 45, 12, 87),
                          shadows: [
                            Shadow(offset: Offset(0, 0)),
                            Shadow(offset: Offset(0, 0)),
                            Shadow(offset: Offset(0, 0)),
                            Shadow(color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    "Nous croyons que la meilleure façon d'apprendre c'est en jouant et en s'amusant. C'est la raison pour laquelle nous avons pensé à créer une application éducative dédiée aux enfants afin de développer leurs compétences de base. Mieux encore, nous le vous faisons en toute sécurité -sous contrôle-. Notre application est essentiellement destinée aux enfants âgés de 5 ans ou moins.",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.055 * screenWidth,
                      fontFamily: 'Boogaloo',
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(height: 0.0074 * screenHeight),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Divider(
                          thickness: 2.5,
                          height: 0.001,
                          color: Color.fromARGB(255, 110, 200, 235),
                        )),
                  ),
                ]),
                Row(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: BorderedText(
                      strokeColor: Color.fromARGB(255, 236, 244, 244),
                      strokeWidth: 3,
                      child: Text(
                        'A propos de nous :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontFamily: 'Boogaloo',
                          fontSize: 0.0694 * screenWidth,
                          color: Color.fromARGB(255, 45, 12, 87),
                          shadows: [
                            Shadow(offset: Offset(0, 0)),
                            Shadow(offset: Offset(0, 0)),
                            Shadow(offset: Offset(0, 0)),
                            Shadow(color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    "Nous sommes un groupe d'étudiantes ambitieuses en 2CPI à l'Ecole Supérieur d'Informatique. Nous tenons à effectuer un travail intact, parfait: On vous propose le meilleur de la science et de la technologie; un jeu éducatif, attractif qui éblouit les petits enfants",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 0.055 * screenWidth,
                      fontFamily: 'Boogaloo',
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                SizedBox(height: 0.0074 * screenHeight),
                Row(children: <Widget>[
                  Expanded(
                    child: new Container(
                        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Divider(
                          thickness: 2.5,
                          height: 0.001,
                          color: Color.fromARGB(255, 110, 200, 235),
                        )),
                  ),
                ]),
                Row(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: BorderedText(
                      strokeColor: Color.fromARGB(255, 236, 244, 244),
                      strokeWidth: 3,
                      child: Text(
                        'Contactez-nous :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontFamily: 'Boogaloo',
                          fontSize: 0.0694 * screenWidth,
                          color: Color.fromARGB(255, 45, 12, 87),
                          shadows: [
                            Shadow(offset: Offset(0, 0)),
                            Shadow(offset: Offset(0, 0)),
                            Shadow(offset: Offset(0, 0)),
                            Shadow(color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: 0.0148 * screenHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => {_launchURLBrowser1()},
                      child: Image(
                        image: AssetImage('images/facebook.png'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {_launchURLBrowser2()},
                      child: Image(
                        image: AssetImage('images/instagram.png'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {print('hhh'), _launchURLBrowser()},
                      child: Image(
                        image: AssetImage('images/website.png'),
                        height: 30,
                        width: 30,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {_launchURLBrowser3()},
                      child: Image(
                        image: AssetImage('images/gmail1.png'),
                        height: 30,
                        width: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
              ],
            )),
      ),
    );
  }
}
