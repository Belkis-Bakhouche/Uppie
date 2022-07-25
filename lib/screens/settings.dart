import 'package:appli/authentification/login.dart';
import 'package:appli/models/user.dart';
import 'package:appli/screens/choose_avatar.dart';
import 'package:flutter_password_strength/flutter_password_strength.dart';
import 'dart:ui';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:appli/screens/help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int scoreUser = 0;
  String avatarUser = '';
  void getUserScore() async {
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
                scoreUser = userId.data['Score'];
              });
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void getUserAvatar() async {
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
                avatarUser = userId.data['Avatar'];
              });
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  double p = 0;
  String mdp = '';
  String traces;
  String domaine = '';
  String level = '';
  String question = '';
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getAvatar();
    getTrace();
    getNom();
    getIntValuesSF();
  }

  String nom;
  getNom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
    });
  }

  String avatarpref;
  getAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      avatarpref = prefs.getString('avatar');
    });
  }

  deconnexion(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.fromLTRB(50, 10, 50, 0),
            contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            scrollable: true,
            backgroundColor: Color.fromARGB(255, 202, 238, 249),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: BorderedText(
                strokeColor: Color.fromARGB(255, 45, 12, 87),
                strokeWidth: 3,
                child: Text(
                  'Déconnexion',
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
            ),
            content: Stack(children: [
              Image(
                image: AssetImage('images/dauphin_settings.png'),
                height: 300,
                width: 300,
              ),
              Positioned(
                top: 30,
                child: Text("Êtes-vous sûr de vouloir déconnecter ?",
                    style: TextStyle(
                      fontFamily: 'Boogaloo',
                      fontSize: 20,
                      color: Colors.black,
                    )),
              ),
              Positioned(
                  top: 240,
                  left: 13,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            color: Color.fromARGB(255, 86, 136, 240),
                            textColor: Colors.white,
                            child: BorderedText(
                              strokeColor: Colors.white,
                              strokeWidth: 0,
                              child: Text(
                                ' Annuler ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 20,
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
                            onPressed: () {}),
                        SizedBox(width: 40),
                        MaterialButton(
                            color: Color.fromARGB(255, 86, 136, 240),
                            textColor: Colors.white,
                            child: BorderedText(
                              strokeColor: Colors.white,
                              strokeWidth: 0,
                              child: Text(
                                'Confirmer',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 20,
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
                            onPressed: () {
                              _auth.signOut();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogIn()));
                            }),
                      ]))
            ]),
          );
        });
  }

  password(BuildContext context) {
    void _changePassword(String password) async {
      //Create an instance of the current user.
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      //Pass in the password to updatePassword.
      user.updatePassword(password).then((_) {
        print("Successfully changed password");
      }).catchError((error) {
        print("Password can't be changed" + error.toString());
        //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
      });
    }
// Future<void> updateUserpassword(String fullNameupdate, String emailupdate,
//       String passwordupdate, String avatarupdate, int scoreupdate) async {
//     final FirebaseUser user = await FirebaseAuth.instance.currentUser();

//     return await usersCollection.document(user.uid).setData({
//       'FullName': fullNameupdate,
//       'Email': emailupdate,
//       'Password': passwordupdate,
//       'Avatar': avatarupdate,
//       'Score': scoreupdate,
//       // niveau, domaine, question
//     });
//   }
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              titlePadding: EdgeInsets.fromLTRB(50, 10, 50, 0),
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              scrollable: true,
              backgroundColor: Color.fromARGB(255, 202, 238, 249),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: BorderedText(
                  strokeColor: Color.fromARGB(255, 45, 12, 87),
                  strokeWidth: 3,
                  child: Text(
                    'Changer le mot de passe',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Boogaloo',
                      fontSize: 25,
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
              content: Column(children: [
                Image(
                  image: AssetImage('images/keys_settings.gif'),
                  height: 100,
                  width: 100,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10.0, 20, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 202, 238, 249),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color.fromARGB(255, 45, 12, 87),
                        )),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 34, 34, 34),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Boogaloo',
                          color: Color.fromARGB(255, 182, 182, 182),
                        ),
                        hintText: "E-mail",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onChanged: (newText) {},
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10.0, 20, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 202, 238, 249),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Color.fromARGB(255, 45, 12, 87),
                        )),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          color: Color.fromARGB(255, 34, 34, 34),
                        ),
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Boogaloo',
                          color: Color.fromARGB(255, 182, 182, 182),
                        ),
                        hintText: "Nouveau mot de passe",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      onChanged: (value) {
                        setState(() {
                          mdp = value;
                        });
                      },
                      onSaved: (value) {
                        setState(() {
                          mdp = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10.0, 20, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 202, 238, 249),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color.fromARGB(255, 45, 12, 87),
                      ),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Boogaloo',
                          color: Color.fromARGB(255, 182, 182, 182),
                        ),
                        hintText: "Confirmer ce mot de passe",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 140, 0),
                  child: Text("Fiabilité :",
                      style: TextStyle(
                        fontFamily: 'Boogaloo',
                        fontSize: 15,
                        color: Colors.black,
                      )),
                ),
              ]),
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 0, 30, 0),
                      child: FlutterPasswordStrength(
                        password: mdp,
                        width: 200,
                        height: 17,
                        radius: 20,
                        strengthCallback: (strength) {
                          debugPrint(strength.toString());
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                        color: Color.fromARGB(255, 86, 136, 240),
                        textColor: Colors.white,
                        child: BorderedText(
                          strokeColor: Colors.white,
                          strokeWidth: 0,
                          child: Text(
                            'Réintialiser',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Boogaloo',
                              fontSize: 20,
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
                        onPressed: () {
                          msg(context);
                          _changePassword(mdp);
                          print('mdp');
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LogIn()));
                        }),
                  ],
                ),
              ],
            );
          });
        });
  }

  msg(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 20),
          scrollable: true,
          backgroundColor: Color.fromARGB(255, 202, 238, 249),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Container(
            child: Image(
              image: AssetImage('images/msg_settings.png'),
              height: 106,
              width: 300,
            ),
          ),
          content: Column(children: [
            Text(
              'Mail de confirmation',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Boogaloo',
                fontSize: 25,
                color: Color.fromARGB(255, 29, 33, 131),
                shadows: [
                  Shadow(offset: Offset(0, 0), color: Colors.grey),
                  Shadow(offset: Offset(0, 0)),
                  Shadow(offset: Offset(0, 0)),
                  Shadow(
                      offset: Offset(1, 1),
                      color: Color.fromARGB(255, 217, 208, 227)),
                ],
              ),
            ),
            SizedBox(height: 17),
            Text(
                "Nous avons envoyé un mail à exemple12@gmail.com pour confirmer le changement de votre mot de passe.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Boogaloo',
                )),
            SizedBox(
              height: 17,
            ),
            Text("Merci de cosulter votre boîte mail.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Boogaloo',
                )),
          ]),
        );
      },
    );
  }

  username(BuildContext context) {
    final CollectionReference usersCollection =
        Firestore.instance.collection('users');
    // String email = '';
    // String password = '';
    // String avatar = '';
    // int score = 0;

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
                  fullname = userId.data['FullName'];
                  email = userId.data['Email'];
                  passwordd = userId.data['Password'];
                  score = userId.data['Score'];
                  avatar = userId.data['Avatar'];
                });
              }
            }
          }
        }
      } catch (e) {
        print(e);
      }
    }

    Future<void> updateUserName(String fullName, String emailupdate,
        String passwordupdate, String avatarupdate, int scoreUser) async {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();

      return await usersCollection.document(user.uid).setData({
        'FullName': fullName,
        'Email': emailupdate,
        'Password': passwordupdate,
        'Avatar': avatarupdate,
        'Score': scoreUser,
        // niveau, domaine, question
      });
    }

    return showDialog(
        context: context,
        builder: (context) {
          String text = '';
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                actionsPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                titlePadding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                scrollable: true,
                backgroundColor: Color.fromARGB(255, 202, 238, 249),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                title: Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: BorderedText(
                    strokeColor: Color.fromARGB(255, 45, 12, 87),
                    strokeWidth: 3,
                    child: Text(
                      "Changer le nom d'utilisateur",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Boogaloo',
                        fontSize: 25,
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
                content: Column(children: [
                  Image(
                    image: AssetImage('images/cute_settings.gif'),
                    height: 100,
                    width: 100,
                  ),
                  Text(text,
                      style: TextStyle(
                        fontFamily: 'Boogaloo',
                        fontSize: 18,
                        color: Color.fromARGB(255, 245, 146, 197),
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10.0, 20, 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 202, 238, 249),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color.fromARGB(255, 45, 12, 87),
                          )),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.account_circle_rounded,
                            color: Color.fromARGB(255, 34, 34, 34),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 17,
                            fontFamily: 'Boogaloo',
                            color: Color.fromARGB(255, 182, 182, 182),
                          ),
                          hintText: "Nouveau nom d'utilisateur",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onChanged: (newText) {
                          nomchanged = newText;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(20, 10.0, 20, 0.0),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: Color.fromARGB(255, 202, 238, 249),
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(
                  //           color: Color.fromARGB(255, 45, 12, 87),
                  //         )),
                  //     child: TextFormField(
                  //       decoration: InputDecoration(
                  //         prefixIcon: Icon(
                  //           Icons.lock_rounded,
                  //           color: Color.fromARGB(255, 34, 34, 34),
                  //         ),
                  //         hintStyle: TextStyle(
                  //           fontSize: 17,
                  //           fontFamily: 'Boogaloo',
                  //           color: Color.fromARGB(255, 182, 182, 182),
                  //         ),
                  //         hintText: "Mot de passe",
                  //         border: InputBorder.none,
                  //         contentPadding: EdgeInsets.all(10),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ]),
                actions: [
                  Container(
                    margin: EdgeInsets.fromLTRB(70, 8, 79, 15),
                    child: MaterialButton(
                        color: Color.fromARGB(255, 86, 136, 240),
                        textColor: Colors.white,
                        child: BorderedText(
                          strokeColor: Colors.white,
                          strokeWidth: 0,
                          child: Text(
                            'Appliquer',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Boogaloo',
                              fontSize: 20,
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
                        onPressed: () {
                          changeusername = true;
                          getUser();
                          updateUserName(
                              nomchanged, email, passwordd, avatar, scoreUser);

                          if (nomchanged.length > 1) {
                            setState(() => text = 'Quel joli nom !');
                          } else {
                            text = '';
                          }
                        }),
                  ),
                ],
              );
            },
          );
        });
  }

  String _selected;
  List<Map> _languages = [
    {
      'id': '1',
      'image': 'images/fr_flag.png',
      'name': 'Français',
    },
    {
      'id': '3',
      'image': 'images/uk_flag.png',
      'name': 'Anglais',
    }
  ];

  language(BuildContext context) {
    TextEditingController costumController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              actionsPadding: EdgeInsets.fromLTRB(10, 0, 33, 10),
              titlePadding: EdgeInsets.fromLTRB(50, 10, 50, 20),
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              scrollable: true,
              backgroundColor: Color.fromARGB(255, 202, 238, 249),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: BorderedText(
                  strokeColor: Color.fromARGB(255, 45, 12, 87),
                  strokeWidth: 3,
                  child: Text(
                    "Changer la langue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Boogaloo',
                      fontSize: 25,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          // bottomLeft
                          offset: Offset(0, 0),
                          color: Colors.grey,
                        ),
                        Shadow(
                          // bottomRight
                          offset: Offset(0, 0),
                        ),
                        Shadow(
                          // topRight
                          offset: Offset(0, 0),
                        ),
                        Shadow(
                          // topLeft
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 167, 193, 246),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                              color: Color.fromARGB(255, 45, 12, 87),
                              style: BorderStyle.solid,
                              width: 0.80),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            alignedDropdown: true,
                            child: DropdownButton(
                              focusColor: Color.fromARGB(255, 167, 193, 246),
                              hint: Text('Selectionnez la langue',
                                  style: TextStyle(
                                    fontFamily: 'Boogaloo',
                                    fontSize: 18.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  )),
                              value: _selected,
                              onChanged: (newValue) {
                                setState(() {
                                  _selected = newValue;
                                });
                              },
                              items: _languages.map((languageItem) {
                                return DropdownMenuItem(
                                    value: languageItem['id'].toString(),
                                    child: Row(children: [
                                      Image.asset(
                                        languageItem['image'],
                                        width: 25,
                                        height: 25,
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: Text(languageItem['name']),
                                      )
                                    ]));
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                  SizedBox(height: 20),
                  MaterialButton(
                      //  elevation: 5,
                      color: Color.fromARGB(255, 86, 136, 240),
                      textColor: Colors.white,
                      child: BorderedText(
                        strokeColor: Colors.white,
                        strokeWidth: 0,
                        child: Text(
                          'Appliquer les changements',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 20,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                // bottomLeft
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                // bottomRight
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                // topRight
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                // topLeft
                                // offset:Offset(4, 4) ,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {}),
                ])
              ],
            );
          });
        });
  }

  int marks;
  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      marks = prefs.getInt('score');
    });
  }

  getTrace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      traces = prefs.getString('trace');
    });
  }

  trace(BuildContext context) {
    // TextEditingController costumController = TextEditingController();

    String pic = "";
    String pic1 = "";
    String pic2 = "";
    if (traces.substring(6, 7) == '1') {
      if (traces.substring(12, 13) == '1') {
        if (traces.substring(21, 23).compareTo('16') >= 0) {
          pic = 'images/star.png';
          pic1 = 'images/star1.png';
          pic2 = 'images/star1.png';
        } else {
          pic = 'images/star1.png';
          pic1 = 'images/star1.png';
          pic2 = 'images/star1.png';
        }
      } else if (traces.substring(12, 13) == '2') {
        if (traces.substring(21, 23).compareTo('22') >= 0) {
          pic = 'images/star.png';
          pic1 = 'images/star.png';
          pic2 = 'images/star1.png';
        } else {
          pic = 'images/star.png';
          pic1 = 'images/star1.png';
          pic2 = 'images/star1.png';
        }
      } else if (traces.substring(12, 13) == '3') {
        if (traces.substring(21, 23).compareTo('32') >= 0) {
          pic = 'images/star.png';
          pic1 = 'images/star.png';
          pic2 = 'images/star.png';
        } else {
          pic = 'images/star.png';
          pic1 = 'images/star.png';
          pic2 = 'images/star1.png';
        }
      }
    } else if (traces.substring(6, 7) == '2') {
      if (traces.substring(12, 13) == '1') {
        if (traces.substring(21, 23).compareTo('7') >= 0) {
          pic = 'images/star.png';
          pic1 = 'images/star1.png';
          pic2 = 'images/star1.png';
        } else {
          pic = 'images/star1.png';
          pic1 = 'images/star1.png';
          pic2 = 'images/star1.png';
        }
      } else if (traces.substring(12, 13) == '2') {
        if (traces.substring(21, 23).compareTo('8') >= 0) {
          pic = 'images/star.png';
          pic1 = 'images/star.png';
          pic2 = 'images/star1.png';
        } else {
          pic = 'images/star.png';
          pic1 = 'images/star1.png';
          pic2 = 'images/star1.png';
        }
      } else if (traces.substring(12, 13) == '3') {
        if (traces.substring(21, 23).compareTo('9') >= 0) {
          pic = 'images/star.png';
          pic1 = 'images/star.png';
          pic2 = 'images/star.png';
        } else {
          pic = 'images/star.png';
          pic1 = 'images/star.png';
          pic2 = 'images/star1.png';
        }
      }
    } else if (traces.substring(6, 7) == '3') {
      if (traces.substring(12, 13) == '1') {
        if (traces.substring(21, 23).compareTo('7') >= 0) {
          pic = 'images/star.png';
          pic1 = 'images/star1.png';
          pic2 = 'images/star1.png';
        } else {
          pic = 'images/star1.png';
          pic1 = 'images/star1.png';
          pic2 = 'images/star1.png';
        }
      } else if (traces.substring(12, 13) == '2') {
        if (traces.substring(21, 23).compareTo('8') >= 0) {
          pic = 'images/star.png';
          pic1 = 'images/star.png';
          pic2 = 'images/star1.png';
        } else {
          pic = 'images/star.png';
          pic1 = 'images/star1.png';
          pic2 = 'images/star1.png';
        }
      } else if (traces.substring(12, 13) == '3') {
        if (traces.substring(21, 23).compareTo('9') >= 0) {
          pic = 'images/star.png';
          pic1 = 'images/star.png';
          pic2 = 'images/star.png';
        } else {
          pic = 'images/star.png';
          pic1 = 'images/star.png';
          pic2 = 'images/star1.png';
        }
      }
    }

    if (traces.substring(6, 7) == '1') {
      domaine = "manières";
    } else if (traces.substring(6, 7) == '2') {
      domaine = "vegs";
    } else if (traces.substring(6, 7) == '3') {
      domaine = "animaux";
    }

    level = traces.substring(12, 13);
    question = traces.substring(21, 23);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.fromLTRB(50, 10, 50, 0),
            actionsPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            scrollable: true,
            backgroundColor: Color.fromARGB(255, 202, 238, 249),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: BorderedText(
              strokeColor: Color.fromARGB(255, 45, 12, 87),
              strokeWidth: 3,
              child: Text(
                'Progression',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Boogaloo',
                  fontSize: 30,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      // bottomLeft
                      offset: Offset(1, 1),
                    ),
                    Shadow(
                      // bottomRight
                      offset: Offset(1, 1),
                    ),
                    Shadow(
                      // topRight
                      offset: Offset(0, 0),
                    ),
                    Shadow(
                      // topLeft
                      offset: Offset(0, 0),
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Column(children: [
                Stack(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 180, 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 40,
                      child: Image.asset(
                        avatarpref,
                        width: 58,
                        height: 58,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 30,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(60, 0, 75, 0),
                      child: Text(nom ?? '',
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 25.0,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Positioned(
                    left: 93,
                    top: 60,
                    child: Row(children: [
                      Image(
                        image: AssetImage(pic),
                        height: 20,
                        width: 20,
                      ),
                      Image(
                        image: AssetImage(pic1),
                        height: 20,
                        width: 20,
                      ),
                      Image(
                        image: AssetImage(pic2),
                        height: 20,
                        width: 20,
                      )
                    ]),
                  ),
                ]),
                SizedBox(height: 10),
                Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadiusDirectional.circular(20),
                        color: Color.fromARGB(230, 125, 151, 159)),
                    padding: EdgeInsets.fromLTRB(150, 50, 150, 50),
                  ),
                  Positioned(
                      top: 15,
                      left: 17,
                      child: Row(
                        children: [
                          Column(children: [
                            Text('Domaine',
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 20.0,
                                  color: Colors.white,
                                )),
                            SizedBox(height: 10),
                            Text(domaine,
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 22.0,
                                  color: Color.fromARGB(210, 192, 51, 194),
                                )),
                          ]),
                          SizedBox(width: 15),
                          Column(children: [
                            Text('Niveau',
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 20.0,
                                  color: Colors.white,
                                )),
                            SizedBox(height: 10),
                            Text(level,
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 22.0,
                                  color: Color.fromARGB(200, 59, 242, 67),
                                )),
                          ]),
                          SizedBox(width: 15),
                          Column(children: [
                            Text('Question',
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 20.0,
                                  color: Colors.white,
                                )),
                            SizedBox(height: 10),
                            Text(question,
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 22.0,
                                  color: Color.fromARGB(205, 251, 226, 0),
                                )),
                          ]),
                        ],
                      )),
                ])
              ]),
            ],
          );
        });
  }

  String passwordd, fullname, email, avatar, nomchanged;
  int score;
  User user;
  bool changeusername = false;
  @override
  Widget build(BuildContext context) {
    /*setString(String key, String value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }*/

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
                  fullname = userId.data['FullName'];
                  email = userId.data['Email'];
                  passwordd = userId.data['Password'];
                  score = userId.data['Score'];
                  avatar = userId.data['Avatar'];
                });
              }
            }
          }
        }
      } catch (e) {
        print(e);
      }
    }

    getUser();
    getUserAvatar();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg_settings.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Annuler',
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 0.05556 * screenWidth,
                            color: Color.fromARGB(255, 208, 240, 253),
                          ))),
                ),
                Center(
                  child: Stack(
                    children: <Widget>[
                      Image(
                          image: AssetImage('images/cloud_settings.png'),
                          height: 0.13392857 * screenHeight,
                          width: 0.472222 * screenWidth),
                      Positioned(
                          child: Text(
                            'Paramètres',
                            style: TextStyle(
                              fontSize: 0.0694444 * screenWidth,
                              fontFamily: 'Boogaloo',
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.white,
                            ),
                          ),
                          right: 0.09166667 * screenWidth,
                          top: 0.03720238 * screenHeight),
                      Positioned(
                        child: Text(
                          'Paramètres',
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 0.0694444 * screenWidth,
                            color: Color.fromARGB(255, 45, 12, 87),
                          ),
                        ),
                        right: 0.09166667 * screenWidth,
                        top: 0.03720238 * screenHeight,
                      ),
                    ],
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Terminer',
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 0.0555556 * screenWidth,
                            color: Color.fromARGB(255, 208, 240, 253),
                          ))),
                ]),
              ],
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseAvatar()),
                  )
                },
                child: CircleAvatar(
                  radius: 0.13888889 * screenWidth,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    avatarUser ?? '',
                    width: 0.222222 * screenWidth,
                    height: 0.1904762 * screenHeight,
                  ),
                ),
              ),
              BorderedText(
                strokeColor: Colors.grey,
                strokeWidth: 3,
                child: Text(
                  fullname ?? ' ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 0.075 * screenWidth,
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
              Stack(children: [
                Image(
                  image: AssetImage('images/diamond_settings.png'),
                ),
                Positioned(
                    child: GestureDetector(
                      onTap: () => {trace(context)},
                      child: Text(
                        marks.toString() ?? '0',
                        style: TextStyle(
                          fontFamily: 'Boogaloo',
                          fontSize: 0.0833333 * screenWidth,
                          color: Color.fromARGB(255, 45, 12, 87),
                        ),
                      ),
                    ),
                    right: 0.125 * screenWidth),
              ]),
              SizedBox(height: 0.05208333 * screenHeight),
            ]),
            Row(
              children: [
                SizedBox(width: 0.13888 * screenWidth),
                CircleAvatar(
                  radius: 0.047222 * screenWidth,
                  backgroundColor: Colors.deepOrange,
                  child: Icon(
                    Icons.account_box,
                    color: Colors.white,
                    size: 0.0297619 * screenHeight,
                  ),
                ),
                SizedBox(height: 0.104166 * screenHeight),
                Container(
                  child: TextButton(
                    onPressed: () {
                      username(context);
                    },
                    child: Text("Nom d'utilisateur",
                        style: TextStyle(
                          fontFamily: 'Boogaloo',
                          fontSize: 0.05555 * screenWidth,
                          color: Color.fromARGB(255, 148, 149, 153),
                        )),
                  ),
                )
              ],
            ),
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
            Row(
              children: [
                SizedBox(width: 0.13888 * screenWidth),
                CircleAvatar(
                  radius: 0.025297 * screenHeight,
                  backgroundColor: Colors.green[500],
                  child: Icon(
                    Icons.lock_rounded,
                    color: Colors.white,
                    size: 0.029762 * screenHeight,
                  ),
                ),
                SizedBox(height: 0.10416 * screenHeight),
                Container(
                  child: TextButton(
                    onPressed: () {
                      password(context);
                    },
                    child: Text('Mot de passe',
                        style: TextStyle(
                          fontFamily: 'Boogaloo',
                          fontSize: 0.05555 * screenWidth,
                          color: Color.fromARGB(255, 148, 149, 153),
                        )),
                  ),
                )
              ],
            ),
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
            Row(
              children: [
                SizedBox(width: 0.1388 * screenWidth),
                CircleAvatar(
                  radius: 0.029762 * screenHeight,
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Icon(
                    Icons.language_rounded,
                    color: Colors.white,
                    size: 0.02976 * screenHeight,
                  ),
                ),
                SizedBox(height: 0.10416 * screenHeight),
                Container(
                  child: TextButton(
                    onPressed: () {
                      language(context);
                    },
                    child: Text('Langue ',
                        style: TextStyle(
                          fontFamily: 'Boogaloo',
                          fontSize: 0.0555 * screenWidth,
                          color: Color.fromARGB(255, 148, 149, 153),
                        )),
                  ),
                )
              ],
            ),
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
            Row(
              children: [
                SizedBox(width: 0.13888 * screenWidth),
                CircleAvatar(
                  radius: 0.02529 * screenHeight,
                  backgroundColor: Colors.lightBlueAccent,
                  child: Icon(
                    Icons.help_rounded,
                    color: Colors.white,
                    size: 0.02976 * screenHeight,
                  ),
                ),
                SizedBox(height: 0.10416 * screenHeight),
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Help()),
                      );
                    },
                    child: Text('Aide',
                        style: TextStyle(
                          fontFamily: 'Boogaloo',
                          fontSize: 0.0555 * screenWidth,
                          color: Color.fromARGB(255, 148, 149, 153),
                        )),
                  ),
                )
              ],
            ),
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
            Row(
              children: [
                SizedBox(width: 0.13888 * screenWidth),
                CircleAvatar(
                  radius: 0.02529762 * screenHeight,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 0.05555 * screenWidth,
                  ),
                ),
                SizedBox(height: 70),
                Container(
                  child: TextButton(
                    onPressed: () {
                      deconnexion(context);
                    },
                    child: Text('Déconnexion',
                        style: TextStyle(
                          fontFamily: 'Boogaloo',
                          fontSize: 0.0555 * screenWidth,
                          color: Color.fromARGB(255, 148, 149, 153),
                        )),
                  ),
                )
              ],
            ),
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
            SizedBox(height: 0.00892857 * screenHeight),
          ],
        ),
      ),
    )));
  }
}
