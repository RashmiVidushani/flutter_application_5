import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/Login/mainlogin.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Gradient _gradient = LinearGradient(
    colors: [Colors.red, Colors.teal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: initScreen(context));
  }

  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainLogin()));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/splash.png', height: 300, width: 300),
            ShaderMask(
              blendMode: BlendMode.modulate,
              shaderCallback: (size) => _gradient.createShader(
                Rect.fromLTWH(0, 0, size.width, size.height),
              ),
              child: Text(
                "Edu-master",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                ),
              ),
            ),
            /*
            Text(
              "Edu-master",
              style: TextStyle(
                  fontSize: 38,
                  color: Colors.teal,
                  fontWeight: FontWeight.w700),
            ),*/
            Text(
              "Your digital School",
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.teal,
                  fontWeight: FontWeight.w700),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.green,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
