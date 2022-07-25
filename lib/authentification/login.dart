import 'dart:ui';
import 'package:appli/authentification/inscription.dart';
import 'package:appli/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  void getUseremail() async {
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
                emailMdpOublie = userId.data['Email'];
                passwordMdpOublie = userId.data['Password'];
              });
            }
          }
        }
      }
    } catch (e) {
      print(e);
    }
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
              height: 150,
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
                "Merci d'envoyer un mail à Uppie06@gmail.com pour changer votre mot de passe.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Boogaloo',
                )),
            SizedBox(
              height: 17,
            ),
          ]),
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String emailMdpOublie = '';
  String emailForgot = '';

  String passwordMdpOublie = '';
  String passwordd = '';
  String error = '';
  String message = '';
  double p = 0;
  String mdp = '';
  bool _passwordVisible;
  // ignore: must_call_super
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    getUseremail();
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/backgroundImage.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 0.2312 * screenHeight),
                Image(
                  image: AssetImage('images/logo.png'),
                  height: 0.2167 * screenHeight,
                  alignment: Alignment.center,
                ),
                Text(
                  "Bienvenue !",
                  style: TextStyle(
                    color: Color.fromARGB(255, 45, 12, 87),
                    fontSize: 0.1527 * screenWidth,
                    fontFamily: 'Boogaloo',
                    letterSpacing: 0.0027 * screenWidth,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(0.0595 * screenHeight),
                          ),
                          child: TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Color.fromARGB(255, 34, 34, 34),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 0.0555 * screenWidth,
                                  fontFamily: 'Boogaloo',
                                  color: Color.fromARGB(255, 217, 208, 227),
                                ),
                                hintText: " email",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                              validator: (value) =>
                                  value.isEmpty ? " Entrer l'email" : null,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                setState(() => email = value);
                              }),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(0.0595 * screenHeight),
                          ),
                          child: TextFormField(
                            obscureText: !_passwordVisible,
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color.fromARGB(255, 34, 34, 34),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              hintStyle: TextStyle(
                                fontSize: 0.0555 * screenWidth,
                                fontFamily: 'Boogaloo',
                                color: Color.fromARGB(255, 217, 208, 227),
                              ),
                              hintText: " mot de passe",
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                            validator: (value) => value.isEmpty
                                ? " Entrer le mot de passe"
                                : null,
                            onChanged: (value) {
                              setState(() => passwordd = value);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    msg(context);
                  },
                  child: Text(
                    'Mot de passe oublié?',
                    style: TextStyle(
                      fontFamily: 'Boogaloo',
                      fontSize: 0.044444 * screenWidth,
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 86, 204, 242),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email: email, password: passwordd);
                        if (result != null) {
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder: (context) =>));
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Mapp()));
                        }
                      } catch (e) {
                        print(e.code);
                        switch (e.code) {
                          case 'ERROR_INVALID_EMAIL':
                            {
                              setState(() {
                                message = 'Vérifier votre addresse email';
                              });
                            }
                            break;
                          case 'ERROR_USER_NOT_FOUND':
                            {
                              setState(() {
                                message = 'Vérifier le mail ou le mot de passe';
                              });
                            }
                            break;
                          case 'ERROR_NETWORK_REQUEST_FAILED':
                            setState(() {
                              message = 'Vérifier votre connexion';
                            });
                            break;
                          case 'ERROR_WRONG_PASSWORD':
                            {
                              setState(() {
                                message = 'Vérifier votre mot de passe';
                              });
                            }
                            break;
                          default:
                            {
                              setState(() {
                                message =
                                    'Connexion échouée, veuillez réssayer';
                              });
                            }
                            return;
                        }
                      }
                    }
                  },
                  child: Text(
                    '    Connexion    ',
                    style: TextStyle(
                      fontFamily: 'Boogaloo',
                      fontSize: 0.0694 * screenWidth,
                      color: Color.fromARGB(255, 45, 12, 87),
                      backgroundColor: Color.fromARGB(255, 251, 233, 142),
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Color.fromARGB(255, 45, 12, 87),
                    backgroundColor: Color.fromARGB(255, 251, 233, 142),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(0.0446 * screenHeight),
                        side: BorderSide(
                          color: Color.fromARGB(255, 251, 233, 142),
                        )),
                  ),
                ),
                SizedBox(height: 0.014881 * screenHeight),
                Text(
                  message,
                  style: TextStyle(
                      color: Colors.red, fontSize: 0.0388 * screenWidth),
                ),
                Row(
                  children: [
                    SizedBox(width: 0.05954 * screenHeight),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "Vous n'avez pas un compte ?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 45, 12, 87),
                          fontFamily: 'Boogaloo',
                          fontSize: 0.047 * screenWidth,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 15, 10.0, 5.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Inscription()),
                          );
                        },
                        child: Text(
                          'Inscription',
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            decoration: TextDecoration.underline,
                            fontSize: 0.05 * screenWidth,
                            color: Colors.white,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          primary: Color.fromARGB(255, 45, 12, 87),
                          onSurface: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.014881 * screenHeight),
              ],
            ),
          ),
        ));
  }
}
