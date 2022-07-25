import 'dart:ui';
import 'package:bordered_text/bordered_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'question1.1.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Learning extends StatefulWidget {
  @override
  _LearningState createState() => _LearningState();
}

enum TtsState { playing, stopped }

class _LearningState extends State<Learning> {
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

  int i = 0;
  int marks;
  FlutterTts flutterTts;
  dynamic languages;
  String language;
  double volume = 1.3;
  double pitch = 1;
  double rate = 0.6;

  String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  initState() {
    super.initState();
    initTts();
    getAvatar();
    getNom();
  }

  String nom;
  getNom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
    });
  }

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }

  void changedLanguage() {
    setState(() {
      flutterTts.setLanguage("fr-FR");
    });
  }

  void _onChange(String text) {
    setState(() {
      _newVoiceText = text;
    });
  }

  String avatarpref;
  getAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      avatarpref = prefs.getString('avatar');
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    List<String> domain1level1texts =
        List.filled(1, '    Maman', growable: true);
    domain1level1texts.add('    Papa');
    domain1level1texts.add('    Frère');
    domain1level1texts.add('    Soeur');
    domain1level1texts.add('    Grand-père');
    domain1level1texts.add('    Grande-mère');
    domain1level1texts.add('  Que la paix soit\n sur vous!');
    domain1level1texts.add("  Au nom d'Allah!");
    domain1level1texts.add('  Dieu merci!');
    domain1level1texts.add('  Dieu merci!');
    domain1level1texts.add('    Bonjour');
    domain1level1texts.add('    Bonsoir');
    domain1level1texts.add('  Ne mange pas!');
    domain1level1texts.add('  Ne mange pas!');
    domain1level1texts.add('  Ne mange pas!');
    domain1level1texts.add('  Ne mange pas!');
    domain1level1texts.add('  Ne mange pas!');
    domain1level1texts.add('  Ne mange pas!');
    domain1level1texts.add('  Le jour');
    domain1level1texts.add('  La nuit');
    /***********************/
    List<String> domain1level1text = List.filled(1, '', growable: true);
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    domain1level1text.add('');
    List<String> domain1level1textunder = List.filled(1, '', growable: true);
    domain1level1textunder.add('');
    domain1level1textunder.add('');
    domain1level1textunder.add('');
    domain1level1textunder.add('');
    domain1level1textunder.add('');
    domain1level1textunder.add('Rentrer à la maison');
    domain1level1textunder.add('  Avant de manger');
    domain1level1textunder.add('    Tousser');
    domain1level1textunder.add('Après avoir manger');
    domain1level1textunder.add("Passer par quelqu'un le matin");
    domain1level1textunder.add("Passer par quelqu'un le soir");
    domain1level1textunder.add('    La morve');
    domain1level1textunder.add('  Tes ongles');
    domain1level1textunder.add('  Les bouttons');
    domain1level1textunder.add('  Les pièces de monnaie');
    domain1level1textunder.add('Les clous et les épingles');
    domain1level1textunder.add('Les médicaments sans contrôle parental');
    domain1level1textunder.add('');
    domain1level1textunder.add('');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 92, 188, 224),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(58.0),
          child: AppBar(
            title: Image.asset(
              'images/manners_bg.png',
              fit: BoxFit.cover,
              height: 80,
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('images/appbar_manners.png'),
                      fit: BoxFit.cover)),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 69, 178, 219),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            actions: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 45, 12, 87),
                    ),
                    onPressed: () {
                      setState(() {
                        if (i > 0) {
                          i--;
                        } else {
                          Navigator.pop(context);
                        }
                      });
                    },
                  ),
                  Column(
                    children: [
                      SizedBox(height: 1),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage(avatarpref ?? 'avatars/girl2.png'),
                      ),
                      Text(
                        nom ?? 'uppie06',
                        style: TextStyle(
                          fontFamily: 'Boogaloo',
                          fontSize: 13,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        Text(
                          'Les bonnes manières',
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 22,
                            color: Colors.white,
                            shadows: [
                              Shadow(offset: Offset(0, 0)),
                              Shadow(offset: Offset(0, 0)),
                              Shadow(offset: Offset(0, 0)),
                              Shadow(offset: Offset(-1, 2)),
                            ],
                          ),
                        ),
                      ])),
                  SizedBox(width: 20),
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Image(
                        image: AssetImage('avatars/niveau1.png'),
                        height: 35,
                        width: 40,
                      ),
                    ],
                  ),
                  SizedBox(width: 38),
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color.fromARGB(255, 200, 234, 246),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Color.fromARGB(255, 29, 33, 131),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 20.0, // soften the shadow
                        spreadRadius: 0.5, //extend the shadow
                        offset: Offset(
                          -5.0, // Move to right 10  horizontally
                          10.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.volume_up_outlined,
                          size: 40,
                        ),
                        onTap: () => {
                          changedLanguage(),
                          _onChange(domain1level1texts[i]),
                          _speak()
                        },
                        onDoubleTap: () => {_stop()},
                      ),
                      BorderedText(
                        strokeColor: Colors.white,
                        strokeWidth: 3,
                        child: Text(
                          domain1level1texts[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 30,
                            color: Color.fromARGB(255, 11, 23, 51),
                            shadows: [
                              Shadow(offset: Offset(0, 0)),
                              Shadow(offset: Offset(0, 0)),
                              Shadow(offset: Offset(0, 0)),
                              Shadow(color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              BorderedText(
                strokeColor: Colors.black,
                strokeWidth: 2.5,
                child: Text(
                  domain1level1text[i],
                  style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 23,
                    color: Colors.white,
                    shadows: [
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(-1, 3)),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                  child: Image(
                    image: AssetImage('assets/photos/Domain1Level1Image$i.png'),
                  ),
                  onTap: () =>
                      {_onChange(domain1level1textunder[i]), _speak()}),
              Text(
                domain1level1textunder[i],
                style: TextStyle(
                  fontFamily: 'Boogaloo',
                  fontSize: 24,
                ),
              ),
              SizedBox(width: 20),
              SizedBox(height: 10),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              if (i < 19) {
                i++;
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Question()));
              }
            });
          },
          backgroundColor: Color.fromARGB(255, 92, 188, 224),
          child: Icon(
            Icons.arrow_forward_rounded,
          ),
        ),
      ),
    );
  }
}
