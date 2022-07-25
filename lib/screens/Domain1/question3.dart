import 'dart:ui';
import 'package:appli/models/user.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:appli/screens/Domain1/question1.1.dart';
import 'NivSup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Levels.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/animation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Question3 extends StatefulWidget {
  @override
  _Question3State createState() => _Question3State();
}

enum TtsState { playing, stopped }

class _Question3State extends State<Question3> {
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

  static int m = 0;
  int cpt = 18;
  int marks;
  int tentative;
  String trace;
  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;

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

  String avatarpref;
  getAvatar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      avatarpref = prefs.getString('avatar');
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

  String passwordd, fullname, email, avatar, nomchanged;
  static String nomaffiche;
  int score;
  User user;
  bool changeusername = false;
  @override
  Widget build(BuildContext context) {
    List<String> domain1Level1Questions = [
      "De quelle période\n de la journée s'agit-il?",
      "De quelle période\n de la journée s'agit-il?"
    ];
    List<String> d1l1q18options = [
      'Domaine1Level2Image10',
      'Domain1Level1Image18',
      'Domain1Level1Image19'
    ];
    List<String> d1l1q19options = [
      'Domaine1Level2Image9',
      'Domain1Level1Image18',
      'Domain1Level1Image19'
    ];
    List<String> texte = ["se reveiller", "dormir"];

    List<List> domain1Level1Indices = [d1l1q18options, d1l1q19options];

    Map<String, Color> btncolor = {
      "a": colortoshow,
    };
    setInt(String key, int value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt(key, value);
    }

    setString(String key, String value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
    }

    void checkanswer(String k) async {
      if (k == 'Domain1Level1Image$cpt') {
        colortoshow = right;
        marks = marks + 1;
        setInt("score", marks);
        setState(() {
          if (m < 1) {
             cpt++;
            setString("trace", 'Domain1Level1question$cpt');
           
            setInt('traceD1L1', cpt + 1);
            m++;
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Congrats()));
          }
        });
      } else {
        colortoshow = wrong;
        tentative--;
        setInt("tentative", tentative);
        if (tentative == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Levels1()));
        }
      }
      setState(() {
        btncolor['assets/photos/' + k + '.png'] = colortoshow;
      });
    }

    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 92, 188, 224),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.119047 * screenHeight),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: AssetImage('images/appbar_manners.png'),
                      fit: BoxFit.cover)),
            ),
            automaticallyImplyLeading: false,
            toolbarHeight: 0.119047 * screenHeight,
            backgroundColor: Color.fromARGB(255, 69, 178, 219),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                          if (m > 0) {
                            m--;
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Question()));
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
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: 0.2777 * screenWidth,
                            height: 0.017857 * screenHeight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(0.02777 * screenWidth)),
                              child: LinearProgressIndicator(
                                value: m / 2,
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
                          height: 0.0521 * screenHeight,
                          width: 0.111 * screenWidth,
                        ),
                        Stack(
                          children: [
                            Image(
                              image: AssetImage('avatars/diamond.png'),
                              width: 0.111 * screenWidth,
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
                              left: 17,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.00446 * screenHeight),
                        Stack(
                          children: [
                            Image(
                              image: AssetImage('images/heart1.png'),
                              width: 0.1111 * screenWidth,
                              height: 0.03005 * screenHeight,
                            ),
                            Positioned(
                              child: Text(
                                tentative.toString(),
                                style: TextStyle(
                                  fontFamily: 'Boogaloo',
                                  fontSize: 0.03888 * screenWidth,
                                ),
                              ),
                              left: 0.0555 * screenWidth,
                            ),
                          ],
                        ),
                      ],
                    ),
                    // SizedBox(width: 0.0333 * screenWidth),
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
              SizedBox(height: 0.0744 * screenHeight),
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
                          size: 0.1111 * screenWidth,
                        ),
                        onTap: () => {
                          changedLanguage(),
                          _onChange(domain1Level1Questions[m]),
                          _speak()
                        },
                        onDoubleTap: () => {_stop()},
                      ),
                      BorderedText(
                        strokeColor: Colors.white,
                        strokeWidth: 3,
                        child: Text(
                          domain1Level1Questions[m],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 0.08333 * screenWidth,
                            color: Color.fromARGB(255, 11, 23, 51),
                            shadows: [
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 0.044643 * screenHeight),
              Stack(children: [
                Image(
                  image: AssetImage('images/bg_vol2.png'),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BorderedText(
                            strokeColor: Colors.white,
                            strokeWidth: 3,
                            child: Text(
                              texte[m],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Boogaloo',
                                fontSize: 0.0777 * screenWidth,
                                color: Colors.black,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 0),
                                  ),
                                  Shadow(
                                    offset: Offset(0, 0),
                                  ),
                                  Shadow(
                                    offset: Offset(0, 0),
                                  ),
                                  Shadow(
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0744 * screenHeight,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(122, 0, 0, 0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Color.fromARGB(255, 241, 222, 53),
                              width: 0.005555 * screenWidth,
                            ),
                          ),
                          child: Image.asset(
                            'assets/photos/' +
                                domain1Level1Indices[m][0] +
                                '.png',
                            width: 0.3888 * screenWidth,
                            height: 0.208333 * screenHeight,
                          ),
                        ),
                      ]),
                ),
                SizedBox(height: 0.014881 * screenHeight),
                Positioned(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(18, 0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black,
                              width: 0.005555 * screenWidth,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                checkanswer(domain1Level1Indices[m][1]),
                            child: Image.asset(
                              'assets/photos/' +
                                  domain1Level1Indices[m][1] +
                                  '.png',
                              width: 0.36111 * screenWidth,
                              height: 0.1934 * screenHeight,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(0.041666 * screenWidth),
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: Colors.black,
                              width: 0.00555 * screenWidth,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () =>
                                checkanswer(domain1Level1Indices[m][2]),
                            child: Image.asset(
                              'assets/photos/' +
                                  domain1Level1Indices[m][2] +
                                  '.png',
                              width: 0.36111 * screenWidth,
                              height: 0.19345 * screenHeight,
                            ),
                          ),
                        ),
                      ]),
                  top: 0.342262 * screenHeight,
                ),
                Positioned(
                    top: 0.540178 * screenHeight,
                    child: Row(children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(50, 0, 0, 0),
                        child: Text(
                          "Le jour",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 0.069444 * screenWidth,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(130, 0, 0, 0),
                        child: Text(
                          "La nuit",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Boogaloo',
                            fontSize: 0.069444 * screenWidth,
                            color: Colors.black,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                              Shadow(
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]))
              ]),
              SizedBox(height: 0.014881 * screenHeight),
            ],
          )),
        ),
      ),
    );
  }
}
