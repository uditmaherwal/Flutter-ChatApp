import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mywhatsapp/helper/authenticate.dart';
import 'package:mywhatsapp/helper/constants.dart';
import 'package:mywhatsapp/helper/helperfunctions.dart';
import 'package:mywhatsapp/screens/SearchScreen.dart';
import 'package:mywhatsapp/screens/SigninPage.dart';
import 'package:mywhatsapp/services/auth.dart';
import 'Calls.dart';
import 'Camera.dart';
import 'Chat.dart';
import 'Status.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _controller;
  AuthMethods _authMethods = AuthMethods();

  @override
  void initState() {
    super.initState();
    _controller = TabController(initialIndex: 1, length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20.0,
        title: Text(
          'ChatOp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ));
            },
            color: Colors.white,
          ),
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'Logout') {
                _authMethods.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Authenticate(),
                  ),
                );
              } else if (value == "Settings") {
              } else {}
            },
            elevation: 5.0,
            itemBuilder: (context) {
              return {'Settings', 'Logout'}.map((String e) {
                return PopupMenuItem<String>(
                  child: Text(e),
                  value: e,
                );
              }).toList();
            },
          )
        ],
        bottom: TabBar(
          indicatorColor: Colors.grey[400],
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          unselectedLabelStyle:
              TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
          indicatorWeight: 3.0,
          tabs: [
            Tab(
              icon: Icon(
                Icons.camera_alt,
                size: 25.0,
              ),
            ),
            Tab(
              child: Text(
                'CHATS',
              ),
            ),
            Tab(
              child: Text(
                'STATUS',
              ),
            ),
            Tab(
              child: Text(
                'CALLS',
              ),
            ),
          ],
          controller: _controller,
        ),
      ),
      body: TabBarView(controller: _controller, children: [
        Camera(),
        Chat(),
        Status(),
        Calls(),
      ]),
    );
  }
}
