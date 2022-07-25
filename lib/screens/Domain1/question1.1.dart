import 'dart:ui';
import 'dart:async';
import 'dart:math';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:appli/screens/Domain1/learning.dart';
import 'question3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Levels.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

enum TtsState { playing, stopped }

class _QuestionState extends State<Question> {
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

  // Future<void> updateUserscore(String fullnameup, String emailupdate,
  //     String passwordupdate, String avatarupdate, int scoreupdate) async {
  //   final FirebaseUser user = await FirebaseAuth.instance.currentUser();

  //   return await usersCollection.document(user.uid).setData({
  //     'FullName': fullnameup,
  //     'Email': emailupdate,
  //     'Password': passwordupdate,
  //     'Avatar': avatarupdate,
  //     'Score': marks,
  //     // niveau, domaine, question
  //   });
  // }

  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  static int i = 0;
  int marks;
  int tentative;
  String trace;
  int lock;
  String k = "a";
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

  @override
  void initState() {
    super.initState();
    initTts();
    getIntValuesSF();
    getIntValues();
    getTrace();
    getIntL();
    getAvatar();
    getNom();
    getIntL1();
  }

  String nom;
  getNom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
    });
  }

  int lock1;
  getIntL1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lock1 = prefs.getInt('traceD1L1');
    });
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

  getIntValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      marks = prefs.getInt('score');
    });
  }

  getIntValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tentative = prefs.getInt('tentative');
    });
  }

  getTrace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      trace = prefs.getString('trace');
    });
  }

  getIntL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lock = prefs.getInt('lock');
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
    List<String> domain1Level1Questions = [
      ' Où est la maman?',
      ' Où est le papa?',
      ' Où est le frère?',
      ' Où est la soeur?',
      ' Où est le grand-père?',
      ' Où est la grande-mère?',
      'Que la paix soit\n sur vous!',
      " Au nom d'Allah!",
      ' Dieu merci!',
      ' Dieu merci!',
      '   Bonjour',
      '   Bonsoir',
      'Il ne faut pas manger?',
      'Il ne faut pas manger?',
      'Il ne faut pas manger?',
      'Il ne faut pas manger?',
      'Il ne faut pas manger?',
      'Il ne faut pas manger?',
      "De quelle période de la journée s'agit-il?",
      "De quelle période de la journée s'agit-il?"
    ];
    List<String> d1l1q0options = [
      'Domain1Level1Image0',
      'Domain1Level1Image5',
      'Domaine1Level3Image1',
      'Domaine1Level2Image2'
    ]; //list of options for the first question
    d1l1q0options
        .shuffle(Random()); //the list of images indices is now shuffled
    List<String> d1l1q1options = [
      'Domain1Level1Image3',
      'Domain1Level1Image4',
      'Domain1Level1Image5',
      'Domain1Level1Image1'
    ];
    d1l1q1options.shuffle(Random());
    List<String> d1l1q2options = [
      'Domain1Level1Image1',
      'Domain1Level1Image2',
      'Domaine1Level2Image3',
      'Domaine1Level2Image1'
    ];
    d1l1q2options.shuffle(Random());
    List<String> d1l1q3options = [
      'Domain1Level1Image0',
      'Domaine1Level3Image2',
      'Domain1Level1Image3',
      'Domaine1Level3Image0'
    ];
    d1l1q3options.shuffle(Random());
    List<String> d1l1q4options = [
      'Domain1Level1Image1',
      'Domain1Level1Image5',
      'Domaine1Level2Image0',
      'Domain1Level1Image4'
    ];
    d1l1q4options.shuffle(Random());
    List<String> d1l1q5options = [
      'Domain1Level1Image0',
      'Domain1Level1Image5',
      'Domaine1Level2Image1',
      'Domaine1Level3Image1'
    ];
    d1l1q5options.shuffle(Random());

    List<String> d1l1q6options = [
      'Domain1Level1Image6',
      'Domain1Level1Image8',
      'Domaine1Level2Image9',
      'Domaine1Level3Image10'
    ];
    d1l1q6options.shuffle(Random());
    List<String> d1l1q7options = [
      'Domain1Level1Image6',
      'Domain1Level1Image7',
      'Domain1Level1Image10',
      'Domain1Level1Image11'
    ];
    d1l1q7options.shuffle(Random());
    List<String> d1l1q8options = [
      'Domain1Level1Image6',
      'Domain1Level1Image7',
      'Domain1Level1Image8',
      'Domain1Level1Image11'
    ];
    d1l1q8options.shuffle(Random());

    List<String> d1l1q9options = [
      'Domain1Level1Image6',
      'Domain1Level1Image7',
      'Domain1Level1Image9',
      'Domain1Level1Image11'
    ];
    d1l1q9options.shuffle(Random());
    List<String> d1l1q10options = [
      'Domain1Level1Image6',
      'Domain1Level1Image7',
      'Domain1Level1Image10',
      'Domain1Level1Image11'
    ];
    d1l1q10options.shuffle(Random());
    List<String> d1l1q11options = [
      'Domain1Level1Image6',
      'Domain1Level1Image7',
      'Domain1Level1Image10',
      'Domain1Level1Image11'
    ];
    d1l1q11options.shuffle(Random());

    List<String> d1l1q12options = [
      'Domain1Level1Option1',
      'Domain1Level1Option2',
      'Domain1Level1Option3',
      'Domain1Level1Image12'
    ];
    d1l1q12options.shuffle(Random());
    List<String> d1l1q13options = [
      'Domain1Level1Option4',
      'Domain1Level1Option5',
      'Domain1Level1Image13',
      'Domain1Level1Option6'
    ];
    d1l1q13options.shuffle(Random());
    List<String> d1l1q14options = [
      'Domain1Level1Image14',
      'Domain1Level1Option1',
      'Domain1Level1Option3',
      'Domain1Level1Option7'
    ];
    d1l1q14options.shuffle(Random());

    List<String> d1l1q15options = [
      'Domain1Level1Option8',
      'Domain1Level1Option5',
      'Domain1Level1Image15',
      'Domain1Level1Option9'
    ];
    d1l1q15options.shuffle(Random());
    List<String> d1l1q16options = [
      'Domain1Level1Image16',
      'Domain1Level1Option1',
      'Domain1Level1Option6',
      'Domain1Level1Option3'
    ];
    d1l1q16options.shuffle(Random());
    List<String> d1l1q17options = [
      'Domain1Level1Option2',
      'Domain1Level1Image17',
      'Domain1Level1Option9',
      'Domain1Level1Option8'
    ];
    d1l1q17options.shuffle(Random());

    List<List> domain1Level1Indices = [
      d1l1q0options,
      d1l1q1options,
      d1l1q2options,
      d1l1q3options,
      d1l1q4options,
      d1l1q5options,
      d1l1q6options,
      d1l1q7options,
      d1l1q8options,
      d1l1q9options,
      d1l1q10options,
      d1l1q11options,
      d1l1q12options,
      d1l1q13options,
      d1l1q14options,
      d1l1q15options,
      d1l1q16options,
      d1l1q17options
    ];

    Map<String, Color> btncolor = {
      "a": Colors.white,
      "b": Colors.white,
      "c": Colors.white,
      "d": Colors.white
    };

    setInt(String key, int value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(key, value);
    }

    setString(String key, String value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }

    checkanswer(String k) {
      if (k == 'Domain1Level1Image$i') {
        colortoshow = right;
        k = "b";
        lock++;
        setInt("lock", lock);
        print(lock);
        marks = marks + 1;
        setInt("score", marks);
        setState(() {
          btncolor[k] = colortoshow;
        });
        setState(() {
          if (i < 17) {
            setString("trace", 'Domain1Level1question$i');
            i++;
            setInt('traceD1L1', i + 1);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Question3()));
          }
        });
      } else {
        k = "c";
        colortoshow = wrong;
        tentative--;
        setInt("tentative", tentative);
        if (tentative == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Levels1()));
        }
        setState(() {
          btncolor[k] = colortoshow;
        });
      }
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 92, 188, 224),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.11904 * screenHeight),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('images/appbar_manners.png'),
                      fit: BoxFit.cover)),
            ),
            automaticallyImplyLeading: false,
            toolbarHeight: 0.11904 * screenHeight,
            backgroundColor: Color.fromARGB(255, 69, 178, 219),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.055555 * screenWidth)),
            elevation: 10,
            actions: [
              Expanded(
                flex: 1,
                child: Row(
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
                        SizedBox(height: 0.02232 * screenHeight),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage(avatarpref ?? 'avatars/girl2.png'),
                        ),
                        Text(
                          nom ?? 'uppie06',
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 0.03611 * screenWidth,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 0.02777 * screenWidth),
                    Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                          Text(
                            'Les bonnes manières',
                            style: TextStyle(
                              fontFamily: 'Boogaloo',
                              fontSize: 0.06111 * screenWidth,
                              color: Colors.white,
                              shadows: [
                                Shadow(offset: Offset(0, 0)),
                                Shadow(offset: Offset(0, 0)),
                                Shadow(offset: Offset(0, 0)),
                                Shadow(offset: Offset(-1, 2)),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            width: 0.2777 * screenWidth,
                            height: 0.01785 * screenHeight,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: i / 18, //this value changes over time
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Color.fromARGB(255, 59, 242, 67)),
                                backgroundColor:
                                    Color.fromARGB(255, 55, 104, 199),
                              ),
                            ),
                          ),
                        ])),
                    SizedBox(width: 0.0555 * screenWidth),
                    Column(
                      children: [
                        Image(
                          image: AssetImage('avatars/niveau1.png'),
                          height: 0.0520833 * screenHeight,
                          width: 0.11111 * screenWidth,
                        ),
                        Stack(
                          children: [
                            Image(
                              image: AssetImage('avatars/diamond.png'),
                              width: 0.11111 * screenWidth,
                              height: 0.03125 * screenHeight,
                            ),
                            Positioned(
                              child: Text(
                                marks.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 0.03888 * screenWidth,
                                ),
                              ),
                              left: 23,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.004 * screenHeight),
                        Stack(
                          children: [
                            Image(
                              image: AssetImage('images/heart1.png'),
                              width: 0.1111 * screenWidth,
                              height: 0.03125 * screenHeight,
                            ),
                            Positioned(
                              child: Text(
                                tentative.toString(),
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 0.038888 * screenWidth,
                                ),
                              ),
                              left: 0.0555555 * screenWidth,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 0.033333 * screenWidth),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              SizedBox(height: 0.07440476 * screenHeight),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.041666 * screenWidth),
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
                          size: 0.05952381 * screenHeight,
                        ),
                        onTap: () => {
                          changedLanguage(),
                          _onChange(domain1Level1Questions[i]),
                          _speak()
                        },
                        onDoubleTap: () => {_stop()},
                      ),
                      BorderedText(
                        strokeColor: Colors.white,
                        strokeWidth: 3,
                        child: Text(
                          domain1Level1Questions[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 0.083333 * screenWidth,
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
              SizedBox(height: 0.04464286 * screenHeight),
              Stack(children: [
                Image(
                  image: AssetImage('images/bg_vol2.png'),
                ),
                Positioned(
                  top: 0.0297619 * screenHeight,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(0.0416666 * screenWidth),
                            color: btncolor[k],
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              width: 0.00555556 * screenWidth,
                              color: Color.fromARGB(255, 69, 178, 219),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                checkanswer(domain1Level1Indices[i][0]),
                            child: Image.asset(
                              'assets/photos/' +
                                  domain1Level1Indices[i][0] +
                                  '.png',
                              width: 0.44444 * screenWidth,
                              height: 0.238095 * screenHeight,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(0.0416666 * screenWidth),
                            color: btncolor[k],
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color.fromARGB(255, 69, 178, 219),
                              width: 0.005555556 * screenWidth,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                checkanswer(domain1Level1Indices[i][1]),
                            child: Image.asset(
                              'assets/photos/' +
                                  domain1Level1Indices[i][1] +
                                  '.png',
                              width: 0.44444 * screenWidth,
                              height: 0.238095 * screenHeight,
                            ),
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 0.01488095 * screenHeight),
                Positioned(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(0.0416666 * screenWidth),
                            color: btncolor[k],
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color.fromARGB(255, 69, 178, 219),
                              width: 0.005555556 * screenWidth,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                checkanswer(domain1Level1Indices[i][2]),
                            child: Image.asset(
                              'assets/photos/' +
                                  domain1Level1Indices[i][2] +
                                  '.png',
                              width: 0.44444 * screenWidth,
                              height: 0.238095 * screenHeight,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(8, 0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(0.041666 * screenWidth),
                            color: btncolor[k],
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color.fromARGB(255, 69, 178, 219),
                              width: 0.00555556 * screenWidth,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                checkanswer(domain1Level1Indices[i][3]),
                            child: Image.asset(
                              'assets/photos/' +
                                  domain1Level1Indices[i][3] +
                                  '.png',
                              width: 0.44444 * screenWidth,
                              height: 0.238095 * screenHeight,
                            ),
                          ),
                        ),
                      ]),
                  top: 0.327381 * screenHeight,
                ),
              ]),
            ],
          )),
        ),
      ),
    );
  }
}
