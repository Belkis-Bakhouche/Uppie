import 'dart:ui';
import 'package:appli/screens/home.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Congrats extends StatefulWidget {
  @override
  _CongratsState createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
   Duration _duration = new Duration();
  Duration _position = new Duration();
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  void initPlayer() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
     audioCache.play('congrats.mp3');
    // ignore: deprecated_member_use
    advancedPlayer.onDurationChanged.listen((Duration d) {
    print('Max duration: $d');
    setState(() => _duration = d);
  });

    // ignore: deprecated_member_use
    advancedPlayer.onAudioPositionChanged.listen((Duration  p) => {
    print('Current position: $p'),
    setState(() => _position = p)
  });
  }
 
  final CollectionReference usersCollection =
      Firestore.instance.collection('users');
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
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(children: [
          SizedBox(height: 0.0744 * screenHeight),
          Center(
            child: Text(
              "Niveau Supérieur !",
              style: TextStyle(
                color: Colors.white,
                fontSize: 0.125 * screenWidth,
                fontFamily: 'Boogaloo',
                letterSpacing: 1.0,
              ),
            ),
          ),
          Row(children: [
            Image(
              image: AssetImage('images/sparkle.gif'),
              width: 0.48611 * screenWidth,
              height: 0.2604 * screenHeight,
            ),
            Image(
              image: AssetImage('images/sparkle.gif'),
              width: 0.48611 * screenWidth,
              height: 0.2604 * screenHeight,
            ),
          ]),
          Row(
            children: [
              Image(
                image: AssetImage('images/sparkle.gif'),
                width: 0.48611 * screenWidth,
                height: 0.2604 * screenHeight,
              ),
              Image(
                image: AssetImage('images/sparkle.gif'),
                width: 0.48611 * screenWidth,
                height: 0.2604 * screenHeight,
              ),
            ],
          ),
          SizedBox(height: 0.20833 * screenHeight),
          Center(
            child: TextButton(
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Mapp()));
                  // Navigator.pop(context);
                  // Navigator.pop(context);
                });
              },
              child: Text(
                '   Continuer   ',
                style: TextStyle(
                  fontFamily: 'Boogaloo',
                  fontSize: 0.08333 * screenWidth,
                  color: Color.fromARGB(255, 45, 12, 87),
                  backgroundColor: Color.fromARGB(255, 251, 233, 142),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Color.fromARGB(255, 45, 12, 87),
                backgroundColor: Color.fromARGB(255, 251, 233, 142),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: Color.fromARGB(255, 251, 233, 142),
                    )),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
