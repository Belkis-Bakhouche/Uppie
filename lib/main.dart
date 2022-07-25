import 'package:appli/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  @override
  // ignore: override_on_non_overriding_member
  setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    setString('hour', '0');
    setString('minute', '0');
    setInt('lock', 0);
    setInt('lock1', 0);
    setInt('lock2', 0);
    return MaterialApp(home: SplashScrn());
  }
}

void setState(Duration Function() param0) {}
