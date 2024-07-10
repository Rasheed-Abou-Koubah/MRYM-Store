import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/component/entercontainers.dart';

class Verify extends StatelessWidget {
  @override
  Widget build(Object context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "MRYM",
            style: TextStyle(
              fontSize: 40.5,
            ),
          ),
        ),
        body: EnterContainer(
            Color: Colors.amber,
            buttonname: "Email Verified",
            onTap: () {
              FirebaseAuth.instance.currentUser!.sendEmailVerification();
            }),
      ),
    );
  }
}
