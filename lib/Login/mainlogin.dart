import 'package:flutter/material.dart';
import 'package:flutter_application_5/Login/emaillogin.dart';
import 'package:flutter_application_5/Login/phonenumber.dart';
import 'package:flutter_application_5/Providers/emailpassauth.dart';
import 'package:flutter_application_5/Providers/googleauth.dart';
import 'package:flutter_application_5/Screens/homescreen.dart';
import 'package:flutter_application_5/Screens/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MainLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: <Widget>[
          // logo
          Column(
            children: [
              Image.asset('assets/out.png'),
              Text(
                'Welcome back!',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.teal[400],
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),

          SizedBox(height: 20),

          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Text('Sign in with any method!!',
                  style: TextStyle(fontSize: 16, color: Colors.black)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'Sign in failed');
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'Sign in cancelled');
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'Sign in successful');
        break;
      default:
        break;
    }
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              bool isSuccess = await authProvider.handleGoogleSignIn();
              if (isSuccess) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              }
            },
            child: Image.asset(
              'assets/email.png',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EmailLogin()));
            },
            child: Image.asset(
              'assets/google.png',
              height: 83,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PhoneNumber()));
            },
            child: Image.asset(
              'assets/mobile.png',
              height: 83,
            ),
          ),
        ],
      ),
    );
  }
}
