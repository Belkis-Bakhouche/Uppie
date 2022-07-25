import 'dart:ui';
import 'package:appli/screens/settings.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Levels extends StatefulWidget {
  @override
  _LevelsState createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
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
                image: AssetImage('images/bg_darkblue.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: screenHeight * 0.0433),
                        CircleAvatar(
                          radius: 0.0372 * screenHeight,
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            'avatars/boy6.png',
                            width: 0.0972 * screenWidth,
                            height: screenHeight * 0.0505,
                          ),
                        ),
                        Stack(
                          children: [
                            Image(
                              image: AssetImage('images/rectangle.png'),
                              width: 0.1944 * screenWidth,
                            ),
                            Positioned(
                              child: Center(
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 200, 234, 246),
                                    fontFamily: "Boogaloo",
                                    fontSize: 0.06 * screenWidth,
                                  ),
                                ),
                              ),
                              top: 0,
                              bottom: 0.0115 * screenHeight,
                              left: 0.03 * screenWidth,
                              right: 0.014 * screenWidth,
                            ),
                            Positioned(
                              child: Image(
                                image: AssetImage('images/diamond.png'),
                              ),
                              top: 0,
                              bottom: 0.013 * screenHeight,
                              left: 0,
                              right: 0.1111 * screenWidth,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 0.6666 * screenWidth),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 0.0144 * screenHeight,
                          ),
                          GestureDetector(
                            onTap: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Settings()))
                            },
                            child: Image.asset(
                              'images/settings.png',
                              width: 0.0972 * screenWidth,
                              height: 0.0505 * screenHeight,
                            ),
                          ),
                          SizedBox(height: 0.0072 * screenHeight),
                          GestureDetector(
                            onTap: () => {},
                            child: Image.asset(
                              'images/sound_on.png',
                              width: 0.0833 * screenWidth,
                              height: 0.0433 * screenHeight,
                            ),
                          ),
                          SizedBox(height: 0.0072 * screenHeight),
                          GestureDetector(
                            onTap: () => {},
                            child: Image.asset(
                              'images/mute.png',
                              width: 0.0833 * screenWidth,
                              height: 0.0433 * screenHeight,
                            ),
                          ),
                        ])
                  ],
                ),
                SizedBox(height: 0.0115 * screenHeight),
                BorderedText(
                  strokeWidth: 0.0111 * screenWidth,
                  child: Text(
                    'Choisir le niveau',
                    style: TextStyle(
                      fontFamily: 'Boogaloo',
                      fontSize: 0.1527 * screenWidth,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(
                              -0.0021 * screenHeight, -0.0021 * screenHeight),
                        ),
                        Shadow(
                          offset: Offset(
                              0.0021 * screenHeight, -0.0021 * screenHeight),
                        ),
                        Shadow(
                          offset: Offset(
                              0.0021 * screenHeight, 0.0021 * screenHeight),
                        ),
                        Shadow(
                          offset: Offset(
                              0.0021 * screenHeight, -0.004 * screenHeight),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0.0072 * screenHeight),
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                          child: Image(
                            image: AssetImage('images/card.png'),
                            width: 0.6944 * screenWidth,
                          ),
                        ),
                        Positioned(
                            child: Column(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                ' Niveau 1',
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 0.1055 * screenWidth,
                                  color: Colors.white,
                                  letterSpacing: -0.0027 * screenWidth,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(-0.0021 * screenHeight,
                                          -0.0014 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                    Shadow(
                                      offset: Offset(-0.0021 * screenHeight,
                                          0.0014 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                    Shadow(
                                      offset: Offset(-0.0021 * screenHeight,
                                          0.0014 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                    Shadow(
                                      offset: Offset(-0.0021 * screenHeight,
                                          0.0021 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 0.0216 * screenHeight),
                            Text(
                              '1 sur 10',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: 'Boogaloo',
                                fontSize: 0.0555 * screenWidth,
                                color: Color.fromARGB(255, 45, 12, 87),
                              ),
                            ),
                          ],
                        )),
                        Positioned(
                          child: Image(
                            image: AssetImage('images/first.png'),
                          ),
                          left: 0.4166 * screenWidth,
                        ),
                      ],
                    ),
                    SizedBox(height: 0.0679 * screenHeight),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                          child: Image(
                            image: AssetImage('images/card.png'),
                            width: 0.6944 * screenWidth,
                          ),
                        ),
                        Positioned(
                            child: Column(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                ' Niveau 2',
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 0.1055 * screenWidth,
                                  color: Colors.white,
                                  letterSpacing: 0.0027 * screenWidth,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(-0.0021 * screenHeight,
                                          0.0014 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                    Shadow(
                                      offset: Offset(-0.0021 * screenHeight,
                                          0.0014 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                    Shadow(
                                      offset: Offset(-0.0021 * screenHeight,
                                          0.0014 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                    Shadow(
                                      offset: Offset(-0.0021 * screenHeight,
                                          0.0021 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 0.0223 * screenHeight),
                            Text(
                              '1 sur 10',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: 'Boogaloo',
                                fontSize: 0.029 * screenHeight,
                                color: Color.fromARGB(255, 45, 12, 87),
                              ),
                            ),
                          ],
                        )),
                        Positioned(
                          child: Image(
                            image: AssetImage('images/second.png'),
                          ),
                          left: 0.223 * screenHeight,
                        ),
                      ],
                    ),
                    SizedBox(height: 0.0669 * screenHeight),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                          child: Image(
                            image: AssetImage('images/card.png'),
                            width: 0.6944 * screenWidth,
                          ),
                        ),
                        Positioned(
                            child: Column(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                ' Niveau 3',
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 0.0564 * screenHeight,
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(-0.0022 * screenHeight,
                                          0.0014 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                    Shadow(
                                      offset: Offset(-0.0022 * screenHeight,
                                          0.0014 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                    Shadow(
                                      offset: Offset(-0.0022 * screenHeight,
                                          0.0014 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                    Shadow(
                                      offset: Offset(-0.0022 * screenHeight,
                                          0.0022 * screenHeight),
                                      color: Color.fromARGB(255, 45, 12, 87),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 0.0216 * screenHeight),
                            Text(
                              '1 sur 10',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontFamily: 'Boogaloo',
                                fontSize: 0.0555 * screenWidth,
                                color: Color.fromARGB(255, 45, 12, 87),
                              ),
                            ),
                          ],
                        )),
                        Positioned(
                          child: Image(
                            image: AssetImage('images/third.png'),
                          ),
                          left: 0.41 * screenWidth,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
