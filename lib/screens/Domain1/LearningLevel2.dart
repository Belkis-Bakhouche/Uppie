import 'dart:ui';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'question1.2.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Learning2 extends StatefulWidget {
  @override
  _LearningState createState() => _LearningState();
}

enum TtsState { playing, stopped }

class _LearningState extends State<Learning2> {
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

  String nomUser = '';

  int i = 0;
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

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
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

  String nom;
  getNom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> domain1level1texts =
        List.filled(1, '    Oncle', growable: true);
    domain1level1texts.add('    Tante');
    domain1level1texts.add('    Cousin');
    domain1level1texts.add('    Cousine');
    domain1level1texts.add('  Petit fils');
    domain1level1texts.add('  Petite fille');
    domain1level1texts.add('    Merci!');
    domain1level1texts.add('    Pardon!');
    domain1level1texts.add('    De rien!');
    domain1level1texts
        .add("C'est en ton nom\n seigneur que je \nvis et je meurs");
    domain1level1texts.add(
        'Dieu merci , que\nparfois nous faire\nmourir, et après\nla résurrection!');
    domain1level1texts.add('  Ne touche pas!');
    domain1level1texts.add('  Ne touche pas!');
    domain1level1texts.add('  Ne touche pas!');
    domain1level1texts.add('  Ne touche pas!');
    domain1level1texts.add('  Ne touche pas!');
    domain1level1texts.add('  Ne touche pas!');

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

    List<String> domain1level1textunder = List.filled(1, '', growable: true);
    domain1level1textunder.add('');
    domain1level1textunder.add('');
    domain1level1textunder.add('');
    domain1level1textunder.add('');
    domain1level1textunder.add('');
    domain1level1textunder.add('On nous fait/offre quelque chose');
    domain1level1textunder
        .add('Reconnaître ses fautes\net vouloir les réparer');
    domain1level1textunder.add("Quand quelqu'un nous remercie");
    domain1level1textunder.add('  Avant de dormir');
    domain1level1textunder.add('    Se réveiller');
    domain1level1textunder.add('    Le feu');
    domain1level1textunder.add('    Les prises');
    domain1level1textunder.add('  Les fils électriques');
    domain1level1textunder.add('Les outils pointus ou tranchants');
    domain1level1textunder.add('  Les animaux errants');
    domain1level1textunder.add('Les produits chimiques');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 92, 188, 224),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(58.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('images/appbar_manners.png'),
                      fit: BoxFit.cover)),
            ),
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
                          color: Colors.white,
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
                      SizedBox(height: 5),
                      Image(
                        image: AssetImage('avatars/niveau1.png'),
                        height: 35,
                        width: 40,
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
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
                    image:
                        AssetImage('assets/photos/Domaine1Level2Image$i.png'),
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
              if (i < 16) {
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
