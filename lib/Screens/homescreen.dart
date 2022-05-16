import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/Pages/camarapage.dart';
import 'package:flutter_application_5/Login/mainlogin.dart';
import 'package:flutter_application_5/Pages/home.dart';
import 'package:flutter_application_5/Providers/googleauth.dart';
import 'package:flutter_application_5/Providers/home_provider.dart';
import 'package:flutter_application_5/Providers/profile_provider.dart';
import 'package:flutter_application_5/Screens/mainchatscreen.dart';
import 'package:flutter_application_5/Screens/profile.dart';
import 'package:flutter_application_5/test.dart';
import 'package:flutter_application_5/widgets/size_constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  //final List<ChatModel>? chats;
  //final ChatModel? sourceChat;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  User? user = FirebaseAuth.instance.currentUser;
  late ProfileProvider profileProvider;
  late AuthProvider authProvider;
  late String currentUserId;
  late HomeProvider homeProvider;
  void googleSignOut() async {
    authProvider.googleSignOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MainLogin()));
  }

  Future<bool> onBackPress() {
    openDialog();
    return Future.value(false);
  }

  void openDialog() async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return SimpleDialog(
            backgroundColor: Colors.black26,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Exit Application',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  Icons.exit_to_app,
                  size: 30,
                  color: Colors.white,
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Sizes.dimen_10),
            ),
            children: [
              const Text(
                'Are you sure?',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: Sizes.dimen_16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 0);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 1);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Sizes.dimen_8),
                      ),
                      padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        })) {
      case 0:
        break;
      case 1:
        exit(0);
    }
  }

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    homeProvider = context.read<HomeProvider>();
    profileProvider = context.read<ProfileProvider>();
    if (authProvider.getFirebaseUserId()?.isNotEmpty == true) {
      currentUserId = authProvider.getFirebaseUserId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainLogin()),
          (Route<dynamic> route) => false);
    }

    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  var selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("EDU-MASTER"),
          actions: [
            IconButton(
                onPressed: () => googleSignOut(),
                icon: const Icon(Icons.logout)),
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Profile()));
                },
                icon: const Icon(Icons.person)),
          ],
          bottom: TabBar(
            controller: _controller,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(
                icon: Icon(Icons.camera_alt),
              ),
              Tab(
                text: "HOME",
              ),
              Tab(
                text: "CHATS",
              ),
              Tab(
                text: "PROFILE",
              )
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: onBackPress,
          child: TabBarView(controller: _controller, children: [
            CamaraPage(),
            Home(),
            /*ChatPage(
          chats: widget.chats,
          sourceChat: widget.sourceChat,
        ),*/
            MianChatScreen(),
            Test(),
          ]),
        ));
  }
}
