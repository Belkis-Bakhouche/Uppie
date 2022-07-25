import 'package:appli/authentification/login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/widgets.dart';

enum APP_PREFERENCES_EVENTS { SOUND_CHANGE }

class SplashScrn extends StatefulWidget {
  @override
  _SplashScrnState createState() => new _SplashScrnState();
}

class _SplashScrnState extends State<SplashScrn> {
  @override
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    double screenWidth = queryData.size.width;
    double screenHeight = queryData.size.height;

    return Material(
      type: MaterialType.transparency,
      child: Stack(children: [
        new SplashScreen(
          imageBackground: AssetImage('images/bg_sps.png'),
          seconds: 10,
          navigateAfterSeconds: LogIn(),
          useLoader: false,
        ),
        Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(48, 0, 0, 0),
              child: Text(
                "Uppie",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 0.152777 * screenWidth,
                  fontFamily: 'Boogaloo',
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Image(
                image: AssetImage('images/logo_sps.png'),
                height: 0.4166667 * screenHeight,
                width: 0.777778 * screenWidth,
              ),
              SpinKitRipple(
                color: Color.fromARGB(255, 92, 188, 224),
                size: 0.1944444 * screenWidth,
              ),
            ])
          ],
        ))
      ]),
    );
  }
}
