import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/Components/Camera&Video/camarascreen.dart';
import 'package:flutter_application_5/Components/Note/notehome.dart';
import 'package:flutter_application_5/Screens/splashscreen.dart';
import 'package:flutter_application_5/Login/emaillogin.dart';
import 'package:flutter_application_5/Login/mainlogin.dart';
import 'package:flutter_application_5/Providers/chat_provider.dart';
import 'package:flutter_application_5/Providers/googleauth.dart';
import 'package:flutter_application_5/Providers/home_provider.dart';
import 'package:flutter_application_5/Providers/profile_provider.dart';
import 'package:flutter_application_5/Components/Scanner/scanner.dart';
import 'package:flutter_application_5/firebase_options.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  cameras = await availableCameras();
  runApp(MyApp(
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
              create: (_) => AuthProvider(
                  firebaseFirestore: firebaseFirestore,
                  prefs: prefs,
                  googleSignIn: GoogleSignIn(),
                  firebaseAuth: FirebaseAuth.instance)),
          Provider<ProfileProvider>(
              create: (_) => ProfileProvider(
                  prefs: prefs,
                  firebaseFirestore: firebaseFirestore,
                  firebaseStorage: firebaseStorage)),
          Provider<HomeProvider>(
              create: (_) =>
                  HomeProvider(firebaseFirestore: firebaseFirestore)),
          Provider<ChatProvider>(
              create: (_) => ChatProvider(
                  prefs: prefs,
                  firebaseStorage: firebaseStorage,
                  firebaseFirestore: firebaseFirestore))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Edu_Master ',
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: SplashScreen(),
          // routes: {'/profile': (context) => Profile()},
        ));
  }
}
