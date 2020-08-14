import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mywhatsapp/helper/helperfunctions.dart';
import 'package:mywhatsapp/screens/Home.dart';
import 'package:mywhatsapp/services/auth.dart';
import 'package:mywhatsapp/services/database.dart';

class SigninPage extends StatefulWidget {
  final Function toggle;
  SigninPage(this.toggle);
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final formKey = GlobalKey<FormState>();
  DatabaseMethods databaseMethods = DatabaseMethods();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthMethods authMethods = AuthMethods();
  QuerySnapshot querySnapshot;

  bool isLoading = false;

  signIn() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailPreferenceKey(emailController.text);

      databaseMethods.getUserEmail(emailController.text).then((value) {
        querySnapshot = value;
        HelperFunctions.saveUserNamePreferenceKey(
            querySnapshot.documents[0].data['username']);
      });

      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveUserLoggedInPreferenceKey(true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Home();
              },
            ),
          );
        }
      });
    }
  }

  navigateToNextScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Home();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hola !'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: RichText(
                  text: TextSpan(
                    text: 'Welcome to',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontStyle: FontStyle.italic,
                    ),
                    children: [
                      TextSpan(
                        text: ' BhaiOp',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(bottom: 120.0)),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        validator: (value) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)
                              ? null
                              : 'Invalid email id';
                        },
                        controller: emailController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'yourname@mail.com',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25.0),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: TextFormField(
                        validator: (value) {
                          return value.length > 6
                              ? null
                              : '6+ characters needed';
                        },
                        controller: passwordController,
                        obscureText: true,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: Container(
                    alignment: Alignment.centerRight,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {},
                            text: 'Forget password?',
                            style: TextStyle(
                                color: Colors.blue[600], fontSize: 16.0),
                          ),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
              ),
              SizedBox(
                width: 300.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    signIn();
                  },
                  splashColor: Colors.blueGrey[500],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                      color: Colors.white,
                    ),
                  ),
                  elevation: 10.0,
                  color: Theme.of(context).accentColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 25.0),
              ),
              SizedBox(
                height: 50.0,
                width: 300.0,
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  label: Text(
                    'Sign In with Google',
                    style: TextStyle(
                      fontSize: 20.0,
                      letterSpacing: 1.0,
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).accentColor,
                  elevation: 10.0,
                  splashColor: Colors.blueGrey[500],
                  icon: Image.asset(
                    'images/glogo.png',
                    scale: 20.0,
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 25.0)),
              Container(
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                    ),
                    children: [
                      TextSpan(
                        text: ' Sign Up',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            widget.toggle();
                          },
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
