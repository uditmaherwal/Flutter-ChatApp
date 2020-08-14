import 'package:flutter/material.dart';
import 'package:mywhatsapp/helper/authenticate.dart';
import 'package:mywhatsapp/helper/helperfunctions.dart';
import 'package:mywhatsapp/screens/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isUserLoggedIn = false;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInPreferenceKey().then((value) {
      setState(() {
        isUserLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp',
      theme: ThemeData(
        primaryColor: Colors.blueGrey[700],
        accentColor: Colors.blueGrey[700],
        tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          bodyText2: TextStyle(
            color: Colors.black,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        bottomAppBarColor: Colors.white,
      ),
      home: isUserLoggedIn ? Home() : Authenticate(),
    );
  }
}
