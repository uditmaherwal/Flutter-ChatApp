import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mywhatsapp/helper/helperfunctions.dart';
import 'package:mywhatsapp/screens/Home.dart';
import 'package:mywhatsapp/services/auth.dart';
import 'package:mywhatsapp/services/database.dart';

class SignupPage extends StatefulWidget {
  final Function toggle;
  SignupPage(this.toggle);
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  DatabaseMethods databaseMethods = DatabaseMethods();
  bool isLoading = false;
  AuthMethods authMethods = AuthMethods();
  final formKey = GlobalKey<FormState>();

  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signMeup() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "first name": fnController.text,
        "last name": lnController.text,
        "username": usernameController.text,
        "email": emailController.text,
      };

      setState(() {
        isLoading = true;
      });

      HelperFunctions.saveUserEmailPreferenceKey(emailController.text);
      HelperFunctions.saveUserNamePreferenceKey(usernameController.text);

      authMethods
          .signUpWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((value) {
        HelperFunctions.saveUserLoggedInPreferenceKey(true);
        databaseMethods.uploadUserInfo(userInfoMap);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Home();
            },
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
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
                    Padding(padding: EdgeInsets.only(bottom: 50.0)),
                    Container(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty || value.length < 3) {
                                    return 'Invalid first name';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: fnController,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  labelText: 'First name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty || value.length < 3) {
                                    return 'Invalid last name';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: lnController,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  labelText: 'Last name',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty || value.length < 3) {
                                    return 'Invalid username';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: usernameController,
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12.0),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12.0),
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
                            SizedBox(
                              child: Container(
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 25.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: '.'),
                                      ],
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            SizedBox(
                              width: 300.0,
                              height: 50.0,
                              child: RaisedButton(
                                onPressed: () {
                                  signMeup();
                                },
                                splashColor: Colors.blueGrey[500],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Text(
                                  'Sign Up',
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
                                  'Sign Up with Google',
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
                                  text: 'Already have an account?',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17.0,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' Sign In',
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
                  ],
                ),
              ),
            ),
    );
  }
}
