import 'dart:ui';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings.dart';
import 'question1.1.dart';
import 'question1.2.dart';
import 'question1.3.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Levels2 extends StatefulWidget {
  @override
  _LevelsState createState() => _LevelsState();
}

class _LevelsState extends State<Levels2> {
  String fullnameLevel = '';
  String emailLevel = '';
  String passwordLevel = '';
  String avatarLevel = '';
  int scoreLevel = 0;
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');

  void getUser() async {
    try {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      FirebaseUser loggedInUser;
      if (user != null) {
        loggedInUser = user;
        await for (var snapshot
            in Firestore.instance.collection('users').snapshots()) {
          for (var userId in snapshot.documents) {
            if (loggedInUser.uid == userId.documentID) {
              setState(() {
                fullnameLevel = userId.data['FullName'];
                emailLevel = userId.data['Email'];
                passwordLevel = userId.data['Password'];
                scoreLevel = userId.data['Score'];
                avatarLevel = userId.data['Avatar'];
              });
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserscore(String fullnameup, String emailupdate,
      String passwordupdate, String avatarupdate, int scoreupdate) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return await usersCollection.document(user.uid).setData({
      'FullName': fullnameup,
      'Email': emailupdate,
      'Password': passwordupdate,
      'Avatar': avatarupdate,
      'Score': marks,
      // niveau, domaine, question
    });
  }

  int marks;
  int lock;
  int lock1;
  int lock2;
  int lock3;
  String traceD2L1;
  @override
  void initState() {
    super.initState();
    getIntValuesSF();
    getIntL();
    getIntL1();
    getIntL2();
    getIntL3();
    getAvatar();
  }

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      marks = prefs.getInt('score');
    });
  }

  getIntL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lock = prefs.getInt('lock1');
    });
  }

  getIntL1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lock1 = prefs.getInt('traceD2L1');
    });
  }

  getIntL2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lock2 = prefs.getInt('traceD2L2');
    });
  }

  getIntL3() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lock3 = prefs.getInt('traceD2L3');
    });
  }

  String avatarpref;
  getAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      avatarpref = prefs.getString('avatar');
    });
  }

  // ignore: non_constant_identifier_names
  locked_level(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage('images/locked_level.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              BorderedText(
                strokeColor: Colors.white,
                strokeWidth: 2,
                child: Text(
                  'Niveau Bloqué !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 30,
                    color: Color.fromARGB(255, 45, 12, 87),
                    shadows: [
                      Shadow(
                        offset: Offset(0, 0),
                        color: Colors.grey,
                      ),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(
                        offset: Offset(1, 1),
                        color: Color.fromARGB(255, 217, 208, 227),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 230,
              ),
              BorderedText(
                strokeColor: Colors.white,
                strokeWidth: 2,
                child: Text(
                  'Débloque-le en succédant le niveau précédent.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 18,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 0),
                        color: Colors.grey,
                      ),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(
                        offset: Offset(1, 1),
                        color: Color.fromARGB(255, 217, 208, 227),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    setInt(String key, int value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(key, value);
    }

    setInt("tentative3", 5);
    setInt("tentative4", 4);
    setInt("tentative5", 3);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/bg_darkblue.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(children: [
                  Column(
                    children: [
                      SizedBox(height: screenHeight * 0.0433),
                      CircleAvatar(
                        radius: 0.0372 * screenHeight,
                        backgroundColor: Colors.white,
                        child: Image.asset(
                          avatarpref     ?? 'images/girl2.png',
                          width: 0.0972 * screenWidth,
                          height: screenHeight * 0.0505,
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Image(
                            image: AssetImage('images/rectangle.png'),
                            width: 0.1944 * screenWidth,
                          ),
                          Positioned(
                            child: Center(
                              child: Text(
                                marks.toString(),
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
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 0.6666 * screenWidth),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    SizedBox(
                      height: 0.0144 * screenHeight,
                    ),
                    // GestureDetector(
                    //   onTap: () => {},
                    //   child: Image.asset(
                    //     'images/sound_off.png',
                    //     width: 0.0833 * screenWidth,
                    //     height: 0.0433 * screenHeight,
                    //   ),
                    // ),
                    SizedBox(height: 0.0072 * screenHeight),
                    GestureDetector(
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
                    SizedBox(height: 0.0072 * screenHeight),
                    // GestureDetector(
                    //   onTap: () => {},
                    //   child: Image.asset(
                    //     'images/music_off.png',
                    //     width: 0.0833 * screenWidth,
                    //     height: 0.0433 * screenHeight,
                    //   ),
                    // ),
                  ]),
                ]),
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
                              -0.0021 * screenHeight, -0.0021 * screenHeight),
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
                              onPressed: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Question1()));
                                });
                              },
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
                              lock1.toString() + ' sur 10',
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
                              onPressed: () {
                                if (lock > 8) {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Question2()));
                                  });
                                } else {
                                  locked_level(context);
                                }
                              },
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
                              lock2.toString() + ' sur 10',
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
                              onPressed: () {
                                if (lock > 16) {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Question3()));
                                  });
                                } else {
                                  locked_level(context);
                                }
                              },
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
                              lock3.toString() + ' sur 10',
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
