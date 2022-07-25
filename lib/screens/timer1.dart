import 'dart:ui';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:appli/screens/Timer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Timing extends StatefulWidget {
  @override
  _TimingState createState() => _TimingState();
}

class _TimingState extends State<Timing> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    String hour;
    String minute;
    setString(String key, String value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg_timer.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: BorderedText(
                  strokeColor: Color.fromARGB(255, 29, 33, 131),
                  strokeWidth: 3,
                  child: Text(
                    "Nous nous soucions du développement mental et physique de votre enfant. Pour une expérience de jeu saine, contrôlez sa durée d'utilisation du téléphone.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Boogaloo',
                      fontSize: 23,
                      color: Colors.white,
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
              SizedBox(height: 190),
              BorderedText(
                strokeColor: Color.fromARGB(255, 29, 33, 131),
                strokeWidth: 3,
                child: Text(
                  "Entrez la durée voulue:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 30,
                    color: Colors.white,
                    shadows: [
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(color: Colors.grey),
                    ],
                  ),
                ),
              ),
              Stack(
                children: [
                  Image(
                    image: AssetImage('images/timer.png'),
                    width: 420,
                    height: 100,
                  ),
                  Positioned(
                    left: 100,
                    right: 208,
                    top: 22,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 248, 226, 30),
                                width: 1),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 55, 104, 199),
                                width: 1),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Boogaloo',
                            color: Color.fromARGB(255, 217, 208, 227),
                          ),
                          hintText: "_ _",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onChanged: (newText) {
                          hour = newText;
                          setString('hour', hour);
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 157,
                    right: 180,
                    top: 43,
                    child: Text(
                      'Hr',
                      style: TextStyle(
                        fontFamily: 'Boogaloo',
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 185,
                    right: 122,
                    top: 22,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 248, 226, 30),
                                width: 1),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 55, 104, 199),
                                width: 1),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 25,
                            fontFamily: 'Boogaloo',
                            color: Color.fromARGB(255, 217, 208, 227),
                          ),
                          hintText: "_ _",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onChanged: (newText) {
                          minute = newText;
                          setString('minute', minute);
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 240,
                    right: 90,
                    top: 43,
                    child: Text(
                      'Min',
                      style: TextStyle(
                        fontFamily: 'Boogaloo',
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
                child: TextButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyHomePage(title: 'Horloge')));
                  },
                  child: Text(
                    '       Continuer       ',
                    style: TextStyle(
                      fontFamily: 'Boogaloo',
                      fontSize: screenWidth * 0.0833,
                      color: Color.fromARGB(255, 45, 12, 87),
                      backgroundColor:
                          Color.fromARGB(255, 251, 233, 142), //FBE98E
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Color.fromARGB(255, 45, 12, 87),
                    backgroundColor: Color.fromARGB(255, 251, 233, 142),
                    onSurface: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.0833),
                        side: BorderSide(
                          color: Color.fromARGB(255, 251, 233, 142),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ]),
          ),
        ),
      ),
    );
  }
}
