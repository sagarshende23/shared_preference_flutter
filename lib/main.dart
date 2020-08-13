import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isFirstScreen = false;

  @override
  void initState() {
    super.initState();
    checkFirstScreen();
  }

  Future<void> checkFirstScreen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //if First statement is Null Or NO Value is returning then it will give us Second Value
    bool seen = (pref.getBool('seen') ?? false);
    if (seen) {
      setState(() {
        isFirstScreen = true;
      });
    } else {
      setState(() {
        isFirstScreen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: !isFirstScreen ? IntroScreen() : HomeScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  void gotoHomeScreen(context) async {
    ///SHare String , int , bool, double
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('seen', true);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
///Sagar shende
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Intro Screen"),
          RaisedButton(
            onPressed: () {
              gotoHomeScreen(context);
            },
            child: Text("GO to HomeScreen"),
          )
        ],
      ),
    ));
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Home Screen",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
