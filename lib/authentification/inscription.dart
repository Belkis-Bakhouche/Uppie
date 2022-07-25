import 'dart:ui';
import 'package:appli/authentification/login.dart';
import 'package:appli/screens/choose_avatar.dart';
import 'package:appli/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inscription extends StatefulWidget {
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  String message = '';
  String avatar = '';
  int score = 0;
  String usernameRegister;
  bool _passwordVisible;
  // ignore: must_call_super
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    // ignore: unused_local_variable
    int age;
    setString(String key, String value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }

    setInt(String key, int value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(key, value);
    }

    setString('trace', '0');
    setInt('lock', 0);
    setInt('lock1', 0);
    setInt('lock2', 0);
    setInt("score", 0);
    setInt('traceD1L1', 0);
    setInt('traceD1L2', 0);
    setInt('traceD1L3', 0);
    setInt('traceD2L1', 0);
    setInt('traceD2L2', 0);
    setInt('traceD2L3', 0);
    setInt('traceD3L1', 0);
    setInt('traceD3L2', 0);
    setInt('traceD3L3', 0);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 50.0),
                  Center(
                    child: Text(
                      "Créer un compte",
                      style: TextStyle(
                        color: Color.fromARGB(255, 45, 12, 87),
                        fontSize: 55,
                        fontFamily: 'Boogaloo',
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Image(
                    image: AssetImage('images/cool_cloud.gif'),
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70.0, 0.0, 70.0, 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Color.fromARGB(255, 34, 34, 34),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Boogaloo',
                            color: Color.fromARGB(255, 217, 208, 227),
                          ),
                          hintText: " Email du parent",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        validator: (newText) =>
                            newText.isEmpty ? '      Entrer un email' : null,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (newText) {
                          email = newText;
                        }, //contains the text that the user entered in this field
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Color.fromARGB(255, 34, 34, 34),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Boogaloo',
                            color: Color.fromARGB(255, 217, 208, 227), //D9D0E3
                          ),
                          hintText: "Nom d'utilisateur",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        validator: (newText) => newText.length < 6
                            ? "     Nom d'utilisateur trop court"
                            : null,
                        onChanged: (newText) {
                          usernameRegister = newText;
                          setString('nom', usernameRegister);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
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
                            fontSize: 20,
                            fontFamily: 'Boogaloo',
                            color: Color.fromARGB(255, 217, 208, 227), //D9D0E3
                          ),
                          hintText: "Mot de passe",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        validator: (newText) => newText.length < 6
                            ? '      Mot de passe trop court'
                            : null,
                        onChanged: (newText) {
                          password = newText;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 0.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.calendar_today_sharp,
                            color: Color.fromARGB(255, 34, 34, 34),
                          ),
                          hintStyle: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Boogaloo',
                            color: Color.fromARGB(255, 217, 208, 227), //D9D0E3
                          ),
                          hintText: "Age de votre enfant",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                        validator: (value) =>
                            value.isEmpty ? " Entrer l'age" : null,
                        onChanged: (newText) {
                          age = int.parse(newText);
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            AuthResult result =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            FirebaseUser newUser = result.user;
                            if (newUser != null) {
                              await DatabaseService(uid: newUser.uid)
                                  .updateUserData(usernameRegister, email,
                                      password, avatar, score);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChooseAvatar()));
                            }
                          } catch (e) {
                            message = 'Vérifier vos informations et réessayer';
                          }
                        }
                      },
                      child: Text(
                        '     Choisir un avatar     ',
                        style: TextStyle(
                          fontFamily: 'Boogaloo',
                          fontSize: 30.0,
                          color: Color.fromARGB(255, 45, 12, 87),
                          backgroundColor: Color.fromARGB(255, 251, 233, 142),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: Color.fromARGB(255, 45, 12, 87),
                        backgroundColor: Color.fromARGB(255, 251, 233, 142),
                        onSurface: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                              color: Color.fromARGB(255, 251, 233, 142),
                            )),
                      ),
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 0.05954 * screenHeight),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text(
                          "Vous avez déjà un compte ?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 45, 12, 87),
                            fontFamily: 'Boogaloo',
                            fontSize: 0.047 * screenWidth,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 15, 10.0, 15.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LogIn()),
                            );
                          },
                          child: Text(
                            'Connexion',
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
                ],
              ),
            )),
      ),
    );
  }
}
