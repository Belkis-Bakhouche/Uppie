import 'package:appli/authentification/login.dart';
import 'package:appli/screens/timer1.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final _auth = FirebaseAuth.instance;

  setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  String time1;
  String time2;
  int minute;
  int hour;
  bool timer = false;
  @override
  void initState() {
    super.initState();
    getHour();
    getMinute();
  }

  getHour() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      time1 = prefs.getString('hour');
    });
  }

  getMinute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      time2 = prefs.getString('minute');
    });
  }

  // ignore: non_constant_identifier_names
  locked_level(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage('images/locked_level.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              BorderedText(
                strokeColor: Colors.white,
                strokeWidth: 2,
                child: Text(
                  'Niveau Bloqué !',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 30,
                    color: Color.fromARGB(255, 45, 12, 87),
                    shadows: [
                      Shadow(
                        offset: Offset(0, 0),
                        color: Colors.grey,
                      ),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(
                        offset: Offset(1, 1),
                        color: Color.fromARGB(255, 217, 208, 227),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 230,
              ),
              BorderedText(
                strokeColor: Colors.white,
                strokeWidth: 2,
                child: Text(
                  'Débloque-le en succédant le niveau précédent.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Boogaloo',
                    fontSize: 18,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        offset: Offset(0, 0),
                        color: Colors.grey,
                      ),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(offset: Offset(0, 0)),
                      Shadow(
                        offset: Offset(1, 1),
                        color: Color.fromARGB(255, 217, 208, 227),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    hour = int.parse(time1);
    minute = int.parse(time2); // red line
    Duration _duration = Duration(seconds: hour * 3600 + minute * 60);
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/setClock.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildSpace(),
              Text(''),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 240, 10, 100),
                child: SlideCountdownClock(
                  duration: _duration,
                  slideDirection: SlideDirection.Up,
                  separator: "-",
                  textStyle: TextStyle(
                    fontSize: 0.0555 * screenWidth,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  separatorTextStyle: TextStyle(
                    fontSize: 0.0555 * screenWidth,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                  onDone: () {
                    locked_level(context);
                    _auth.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LogIn()));
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/timer.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                margin: EdgeInsets.fromLTRB(113, 0, 135, 20),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.all(24),
                    textStyle: TextStyle(
                        fontSize: 0.0555 * screenWidth, fontFamily: 'Boogaloo'),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Timing()));
                  },
                  child: Text('Régler'),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(100, 0, 100, 49),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.all(25),
                    textStyle: TextStyle(fontSize: 20, fontFamily: 'Boogaloo'),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Démarrer'),
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/timer.png'),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpace() {
    return SizedBox(height: 0);
  }
}
