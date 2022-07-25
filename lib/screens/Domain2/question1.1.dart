import 'dart:ui';
import 'dart:math';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'NivSup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Levels.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Question1 extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

enum TtsState { playing, stopped }

class _QuestionState extends State<Question1> {
  String fullnameLevel = '';
  String emailLevel = '';
  String passwordLevel = '';
  String avatarLevel = '';
  int scoreLevel = 0;
  int cpt = 0;
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

  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  static int i = 0;
  int marks;
  int tentative;
  String trace;
  int lock;
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
      tentative = prefs.getInt('tentative3');
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

  String nom;
  getNom() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> domain2Level1Questions = [
      ' Où est la pomme?',
      " Où est l'orange?",
      ' Où est la banane?',
      ' Où est la fraise?',
      " Où est l'abricot?",
      ' Où est la tomate?',
      " Où est l'oignon?",
      ' Où est la laitue?',
      ' Où est la carotte?',
      ' Où est la pomme \nde terre?'
    ];
    List<String> d2l1q0options = [
      'Domain2Level1Image0',
      'Domain2Level1Image3',
      'Domain2Level1Image4',
      'Domain2Level1Image8'
    ]; //list of options for the first question
    d2l1q0options
        .shuffle(Random()); //the list of images indices is now shuffled
    List<String> d2l1q1options = [
      'Domain2Level1Image1',
      'Domain2Level1Image5',
      'Domain2Level1Image6',
      'Domain2Level1Image9'
    ];
    d2l1q1options.shuffle(Random());
    List<String> d2l1q2options = [
      'Domain2Level1Image2',
      'Domain2Level1Image0',
      'Domain2Level1Image5',
      'Domain2Level1Image8'
    ];
    d2l1q2options.shuffle(Random());
    List<String> d2l1q3options = [
      'Domain2Level1Image5',
      'Domain2Level1Image7',
      'Domain2Level1Image3',
      'Domain2Level1Image4'
    ];
    d2l1q3options.shuffle(Random());
    List<String> d2l1q4options = [
      'Domain2Level1Image1',
      'Domain2Level1Image4',
      'Domain2Level1Image6',
      'Domain2Level2Image4'
    ];
    d2l1q4options.shuffle(Random());
    List<String> d2l1q5options = [
      'Domain2Level2Image5',
      'Domain2Level1Image5',
      'Domain2Level1Image3',
      'Domain2Level1Image7'
    ];
    d2l1q5options.shuffle(Random());

    List<String> d2l1q6options = [
      'Domain2Level1Image6',
      'Domain2Level1Image8',
      'Domain2Level2Image0',
      'Domain2Level2Image7'
    ];
    d2l1q6options.shuffle(Random());
    List<String> d2l1q7options = [
      'Domain2Level1Image9',
      'Domain2Level1Image7',
      'Domain2Level1Image5',
      'Domain2Level1Image4'
    ];
    d2l1q7options.shuffle(Random());
    List<String> d2l1q8options = [
      'Domain2Level1Image8',
      'Domain2Level1Image1',
      'Domain2Level1Image2',
      'Domain2Level2Image8'
    ];
    d2l1q8options.shuffle(Random());

    List<String> d2l1q9options = [
      'Domain2Level1Image5',
      'Domain2Level1Image9',
      'Domain2Level2Image0',
      'Domain2Level2Image7'
    ];
    d2l1q9options.shuffle(Random());

    List<List> domain2Level1Indices = [
      d2l1q0options,
      d2l1q1options,
      d2l1q2options,
      d2l1q3options,
      d2l1q4options,
      d2l1q5options,
      d2l1q6options,
      d2l1q7options,
      d2l1q8options,
      d2l1q9options
    ];

    setInt(String key, int value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(key, value);
    }

    setString(String key, String value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }

    Map<String, Color> btncolor = {
      "a": colortoshow,
    };

    void checkanswer(String k) {
      if (k == 'Domain2Level1Image$i') {
        colortoshow = right;
        lock++;
        setInt("lock1", lock);
        marks = marks + 1;
        setInt("score", marks);
        setState(() {
          btncolor['assets/photos1/' + k + '.png'] = colortoshow;
        });
        setState(() {
          if (i < 9) {
            i++;
            cpt = i + 1;
            setString("trace", 'Domain2Level1question$cpt');
            setInt('traceD2L1', i + 1);
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Congrats()));
          }
        });
      } else {
        colortoshow = wrong;
        tentative--;
        setInt("tentative3", tentative);
        if (tentative == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Levels2()));
        }
        setState(() {
          btncolor['assets/photos1/' + k + '.png'] = colortoshow;
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
                      image: AssetImage('images/appbar_fruits.png'),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Levels2()));
                          }
                        });
                      },
                    ),
                    Column(
                      children: [
                        SizedBox(height: 0.02232 * screenHeight),
                        CircleAvatar(
                          backgroundImage: AssetImage(avatarpref ?? ''),
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
                            'Les fruits et légumes',
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
                                value: i / 10,
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
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 0.03888 * screenWidth,
                                ),
                              ),
                              left: 20,
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
                          _onChange(domain2Level1Questions[i]),
                          _speak()
                        },
                        onDoubleTap: () => {_stop()},
                      ),
                      BorderedText(
                        strokeColor: Colors.white,
                        strokeWidth: 3,
                        child: Text(
                          domain2Level1Questions[i],
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
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color.fromARGB(255, 69, 178, 219),
                              width: 0.00555556 * screenWidth,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                checkanswer(domain2Level1Indices[i][0]),
                            child: Image.asset(
                              'assets/photos1/' +
                                  domain2Level1Indices[i][0] +
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
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color.fromARGB(255, 69, 178, 219),
                              width: 0.005555556 * screenWidth,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                checkanswer(domain2Level1Indices[i][1]),
                            child: Image.asset(
                              'assets/photos1/' +
                                  domain2Level1Indices[i][1] +
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
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color.fromARGB(255, 69, 178, 219),
                              width: 0.005555556 * screenWidth,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                checkanswer(domain2Level1Indices[i][2]),
                            child: Image.asset(
                              'assets/photos1/' +
                                  domain2Level1Indices[i][2] +
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
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color.fromARGB(255, 69, 178, 219),
                              width: 0.00555556 * screenWidth,
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                checkanswer(domain2Level1Indices[i][3]),
                            child: Image.asset(
                              'assets/photos1/' +
                                  domain2Level1Indices[i][3] +
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
