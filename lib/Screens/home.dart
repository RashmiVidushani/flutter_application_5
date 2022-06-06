import 'package:flutter/material.dart';
import 'package:flutter_application_5/Components/Note/notehome.dart';
import 'package:flutter_application_5/Components/Scanner/scanner.dart';
import 'package:flutter_application_5/Components/email/email.dart';
import 'package:flutter_application_5/Login/mainlogin.dart';
import 'package:flutter_application_5/Providers/emailpassauth.dart';
import 'package:flutter_application_5/test.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end, children: [_getFAB()]),
      body: Center(
          child: Container(
              child: GridView.extent(
        primary: false,
        padding: const EdgeInsets.symmetric(vertical: 75.0, horizontal: 5.0),
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        maxCrossAxisExtent: 200.0,
        children: <Widget>[
          Image.asset('assets/convo.png', height: 300, width: 300),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Test()));
            },
            child: Container(
                color: Colors.teal[800],
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(children: const [
                    SizedBox(
                      height: 25,
                    ),
                    Icon(Icons.forum, size: 80),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Forums",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ]),
                )),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Test()));
            },
            child: Container(
                color: Colors.teal[600],
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(children: const [
                    SizedBox(
                      height: 25,
                    ),
                    Icon(Icons.link, size: 80),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Special Links",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ]),
                )),
          ),
          GestureDetector(
            onTap: () {
              /*AuthenticationHelper()
                  .signOut()
                  .then((_) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (contex) => MainLogin()),
                      ));*/
            },
            child: Container(
                color: Colors.teal[200],
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Column(children: const [
                    SizedBox(
                      height: 25,
                    ),
                    Icon(Icons.video_call_sharp, size: 80),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Zoom",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ]),
                )),
          ),
        ],
      ))),
    );
  }

  Widget _getFAB() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Colors.teal,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
          child: Icon(Icons.note_alt_sharp),
          backgroundColor: Color.fromARGB(255, 141, 182, 178),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => NoteHome()));
          },
          label: 'Notes',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Color.fromARGB(255, 80, 102, 100),
        ),
        // FAB 2
        SpeedDialChild(
          child: Icon(Icons.image_search),
          backgroundColor: Color.fromARGB(255, 141, 182, 178),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Scanner()));
          },
          label: 'OCR',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Color.fromARGB(255, 80, 102, 100),
        ),
        SpeedDialChild(
          child: Icon(Icons.mail),
          backgroundColor: Color.fromARGB(255, 141, 182, 178),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => RegRequest()));
          },
          label: 'E-mail',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Color.fromARGB(255, 80, 102, 100),
        ),
        SpeedDialChild(
          child: Icon(Icons.link),
          backgroundColor: Color.fromARGB(255, 141, 182, 178),
          onTap: () {
            /*Navigator.push(
                context, MaterialPageRoute(builder: (context) => Scanner()));*/
          },
          label: 'Links',
          labelStyle: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.white, fontSize: 16.0),
          labelBackgroundColor: Color.fromARGB(255, 80, 102, 100),
        ),
      ],
    );
  }
}
