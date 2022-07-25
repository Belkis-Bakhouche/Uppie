import 'dart:ui';
import 'package:appli/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChooseAvatar extends StatefulWidget {
  @override
  _ChooseAvatarState createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
  String picName = '';
  String fullnameAvatar = '';
  String emailAvatar = '';
  String passwordAvatar = '';
  String avatarAvatar = '';
  int scoreAvatar = 0;
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
                fullnameAvatar = userId.data['FullName'];
                emailAvatar = userId.data['Email'];
                passwordAvatar = userId.data['Password'];
                scoreAvatar = userId.data['Score'];
                avatarAvatar = userId.data['Avatar'];
              });
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateUserAvatar(String fullNameupdate, String emailupdate,
      String passwordupdate, String avatarupdate, int scoreupdate) async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    return await usersCollection.document(user.uid).setData({
      'FullName': fullNameupdate,
      'Email': emailupdate,
      'Password': passwordupdate,
      'Avatar': avatarupdate,
      'Score': scoreupdate,
      // niveau, domaine, question
    });
  }

  @override
  Widget build(BuildContext context) {
    setString(String key, String value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }

    print(
        '*************************************************************************************************');
    print(picName);
    print(fullnameAvatar);
    getUser();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 128, 234, 247),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(height: 0.0297 * screenHeight),
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color.fromARGB(255, 45, 12, 87),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                alignment: Alignment.topLeft,
              ),
              BorderedText(
                strokeColor: Color.fromARGB(255, 11, 23, 51),
                strokeWidth: 0.0111 * screenWidth,
                child: Text(
                  'Choisir un avatar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 0.1527 * screenWidth,
                    color: Colors.white,
                    shadows: [
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(-2, 4)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 0.0446 * screenHeight),
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 0.0148 * screenHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/boy.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.lightBlue,
                            radius: 0.0595 * screenHeight,
                            child: Image.asset(
                              'avatars/boy.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/girl.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.amberAccent,
                            radius: 0.0595 * screenHeight,
                            child: Image.asset(
                              'avatars/girl.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/boy1.png',
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            setString("avatar", picName),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.deepOrangeAccent,
                            child: Image.asset(
                              'avatars/boy1.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/girl1.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.lightGreenAccent,
                            child: Image.asset(
                              'avatars/girl1.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                      ],
                    ),
                    SizedBox(height: 0.0148 * screenHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/boy2.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.lightGreenAccent,
                            child: Image.asset(
                              'avatars/boy2.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/girl2.png',
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            setString("avatar", picName),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.deepOrangeAccent,
                            child: Image.asset(
                              'avatars/girl2.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/boy3.png',
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            setString("avatar", picName),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.lightBlue,
                            child: Image.asset(
                              'avatars/boy3.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/girl3.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.pink[300],
                            child: Image.asset(
                              'avatars/girl3.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                      ],
                    ),
                    SizedBox(height: 0.0148 * screenHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/boy4.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.pink[300],
                            child: Image.asset(
                              'avatars/boy4.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/girl4.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.lightBlue,
                            child: Image.asset(
                              'avatars/girl4.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/boy5.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.amberAccent,
                            child: Image.asset(
                              'avatars/boy5.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/girl5.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.lightGreenAccent,
                            child: Image.asset(
                              'avatars/girl5.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.0148 * screenHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/boy6.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.amberAccent,
                            child: Image.asset(
                              'avatars/boy6.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/girl6.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.pink[300],
                            child: Image.asset(
                              'avatars/girl6.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/boy7.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.lightBlue,
                            child: Image.asset(
                              'avatars/boy7.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                        SizedBox(width: 0.0083 * screenWidth),
                        GestureDetector(
                          onTap: () => {
                            picName = 'avatars/girl7.png',
                            setString("avatar", picName),
                            updateUserAvatar(fullnameAvatar, emailAvatar,
                                passwordAvatar, picName, scoreAvatar),
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Mapp()))
                          },
                          child: CircleAvatar(
                            radius: 0.0595 * screenHeight,
                            backgroundColor: Colors.deepOrangeAccent,
                            child: Image.asset(
                              'avatars/girl7.png',
                              width: 0.1805 * screenWidth,
                              height: 0.0967 * screenHeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.0148 * screenHeight),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0.0),
              //   child: TextButton(
              //     onPressed: () async {
              //       Navigator.pushReplacement(context,
              //           MaterialPageRoute(builder: (context) => Mapp()));
              //     },
              //     child: Text(
              //       '         Allons-y        ',
              //       style: TextStyle(
              //         fontFamily: 'Boogaloo',
              //         fontSize: 0.0833 * screenWidth,
              //         color: Color.fromARGB(255, 45, 12, 87),
              //         backgroundColor: Color.fromARGB(255, 251, 233, 142),
              //       ),
              //     ),
              //     style: TextButton.styleFrom(
              //       primary: Color.fromARGB(255, 45, 12, 87),
              //       backgroundColor: Color.fromARGB(255, 251, 233, 142),
              //       onSurface: Colors.grey,
              //       shape: RoundedRectangleBorder(
              //           borderRadius:
              //               BorderRadius.circular(0.0833 * screenWidth),
              //           side: BorderSide(
              //             color: Color.fromARGB(255, 251, 233, 142),
              //           )),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
