import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:untitled/add.dart';
import 'package:untitled/display.dart';
import 'package:untitled/edit.dart';

import 'package:untitled/login.dart';
import 'package:untitled/me.dart';
import 'package:untitled/notification.dart';
import 'package:untitled/pickimage.dart';
import 'package:untitled/realtime.dart';
import 'package:untitled/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  // void initState() {
  //   // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   //   if (message.notification != null) {
  //   //     print("===============================");
  //   //     print("===============================");
  //   //     print("===============================");
  //   //   }
  //   // });

  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user == null) {
  //       print('============================User is currently signed out!');
  //     } else {
  //       print('============================User is signed in!');
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: Imagetest(),
      // login_page(),
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? me()
          : login_page(),
      routes: {
        "Register": (context) => const Register(),
        "login": (context) => const login_page(),
        "me": (context) => me(),
        "Add": (context) => Add(),
        "Display": (context) => Display(),
        "pickimage": (context) => Pickimage(),
      },
    );
  }
}
