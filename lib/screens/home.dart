import 'package:bordered_text/bordered_text.dart';
import 'Domain1/Levels.dart';
import 'Domain2/Levels.dart';
import 'Domain3/Levels.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appli/screens/timer.dart';
import 'package:appli/screens/settings.dart';

class Mapp extends StatefulWidget {
  @override
  _MappState createState() => _MappState();
}

class _MappState extends State<Mapp> {
  setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  // ignore: non_constant_identifier_names
  coming_soon(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            scrollable: true,
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Container(
              child: BorderedText(
                strokeColor: Colors.black,
                strokeWidth: 1,
                child: Text(
                  'Bientôt disponible !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 30,
                    color: Color.fromARGB(255, 251, 226, 0),
                    shadows: [
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(
                        offset: Offset(1, 1),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            content: Column(children: [
              Image(
                image: AssetImage('images/coming_soon.gif'),
                height: 300,
                width: 300,
              ),
              Text(
                "Ce jeu sera bientôt disponible.\n        Restez branchés !",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Boogaloo",
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // setInt("score", 0);
    // setInt('traceD1L1', 0);
    // setInt('traceD1L2', 0);
    // setInt('traceD1L3', 0);q
    // setInt('traceD2L1', 0);
    // setInt('traceD2L2', 0);
    // setInt('traceD2L3', 0);
    // setInt('traceD3L1', 0);
    // setInt('traceD3L2', 0);
    // setInt('traceD3L3', 0);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    print(screenWidth);
    print(screenHeight);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/image_part_001.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Settings()))
                      },
                      child: Image.asset(
                        'images/settings.png',
                        width: 0.0972 * screenWidth,
                        height: 0.0505 * screenHeight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                    child: GestureDetector(
                      onTap: () => {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyHomePage(title: 'Horloge'),
                            ),
                          );
                        })
                      },
                      child: Image.asset(
                        'images/chronometer.png',
                        width: 25,
                        height: 0.0505 * screenHeight,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(160, 0, 0, 0),
                    child: Image(
                      image: AssetImage('images/crab.gif'),
                      width: 0.425 * screenWidth,
                      height: 0.07441 * screenHeight,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(51.5, 130, 0, 0),
                        child: GestureDetector(
                          onTap: () => {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Levels1()));
                            }),
                          },
                          child: Image.asset(
                            'images/manners.png',
                            height: 0.07441 * screenHeight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(76, 130, 0, 0),
                        child: GestureDetector(
                          onTap: () => {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Levels3()));
                            }),
                          },
                          child: Image.asset(
                            'images/animals.png',
                            height: 0.07441 * screenHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Image(
                          image: AssetImage('images/boat1.gif'),
                          width: 0.41666 * screenWidth,
                          height: 0.2232 * screenHeight,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Image(
                          image: AssetImage('images/boat2.gif'),
                          width: 0.41666 * screenWidth,
                          height: 0.2232 * screenHeight,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                    child: Image(
                      image: AssetImage('images/fish2.gif'),
                      height: 0.14881 * screenHeight,
                      width: 0.27777 * screenWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/image_part_002.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(160, 130, 0, 0),
                    child: Image(
                      image: AssetImage('images/turtle.png'),
                      width: 0.27777 * screenWidth,
                      height: 0.0744 * screenHeight,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(51, 115, 0, 0),
                        child: GestureDetector(
                          onTap: () => {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Levels2()));
                            }),
                          },
                          child: Image.asset(
                            'images/vegs.png',
                            height: 0.0744 * screenHeight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(69, 115, 0, 0),
                        child: GestureDetector(
                          onTap: () => {coming_soon(context)},
                          child: Image.asset(
                            'images/colors.png',
                            height: 0.0744 * screenHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Image(
                          image: AssetImage('images/boat1.gif'),
                          width: 0.4166 * screenWidth,
                          height: 0.2232 * screenHeight,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Image(
                          image: AssetImage('images/boat2.gif'),
                          width: 0.41666 * screenWidth,
                          height: 0.2232 * screenHeight,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Image(
                      image: AssetImage('images/jellyfish2.gif'),
                      height: 0.14881 * screenHeight,
                      width: 0.2777 * screenWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/image_part_003.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 0.208333 * screenHeight),
                  Image(
                    image: AssetImage('images/daulphin.gif'),
                    height: 0.14881 * screenHeight,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(47, 55, 0, 0),
                        child: GestureDetector(
                          onTap: () => {coming_soon(context)},
                          child: Image.asset(
                            'images/shapes.png',
                            height: 0.0744 * screenHeight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(71, 55, 0, 0),
                        child: GestureDetector(
                          onTap: () => {coming_soon(context)},
                          child: Image.asset(
                            'images/alphabets.png',
                            height: 0.0744 * screenHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 38, 0, 0),
                        child: Image(
                          image: AssetImage('images/boat1.gif'),
                          width: 0.416666 * screenWidth,
                          height: 0.2232 * screenHeight,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 38, 0, 0),
                        child: Image(
                          image: AssetImage('images/boat2.gif'),
                          width: 0.416666 * screenWidth,
                          height: 0.2232 * screenHeight,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Image(
                          image: AssetImage('images/fish.gif'),
                          height: 0.14881 * screenHeight,
                          width: 0.222 * screenWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 80, 0, 0),
                        child: Image(
                          image: AssetImage('images/jellyfish.gif'),
                          height: 0.0744 * screenHeight,
                          width: 0.55555 * screenWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
