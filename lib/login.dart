import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/component/entercontainers.dart';
import 'package:untitled/component/textformfeild.dart';
import 'package:untitled/component/email.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  late final String displayEmail;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    displayEmail = googleUser.email;
    print("============================");
    print(displayEmail);
    print("============================");

    StoreEmail.setEmail(displayEmail);

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    //return await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacementNamed("me");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          // title: const Text(
          //   "MRYM",
          //   style: TextStyle(
          //     fontSize: 40.5,
          //   ),
          // ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  // const Icon(
                  //   Icons.person_pin,
                  //   color: Colors.blueGrey,
                  //   size: 150,
                  // ),
                  Image.asset("assets/images/logonew.png"),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  SizedBox(
                      height: 45,
                      child: CustomTextForm(
                          textfeild: "email",
                          mycontroller: email,
                          myicon: const Icon(
                            Icons.person,
                            color: Colors.blueGrey,
                          ))),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 45,
                    child: CustomTextForm(
                        textfeild: "password",
                        mycontroller: password,
                        myicon: const Icon(
                          Icons.lock,
                          color: Colors.blueGrey,
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  EnterContainer(
                    onTap: () async {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email.text, password: password.text);
                        StoreEmail.setEmail(email.text);
                        if (credential.user!.emailVerified) {
                          Navigator.of(context).pushReplacementNamed("me");
                        } else {
                          "Please verify your Email";
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    },
                    buttonname: "Sign In",
                    Color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      if (email.text == null) {
                        return;
                      }
                      await FirebaseAuth.instance
                          .sendPasswordResetEmail(email: email.text);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 2, bottom: 20),
                      alignment: Alignment.topRight,
                      child: const Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    child: Text(
                      "or",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  EnterContainer(
                    onTap: () {
                      signInWithGoogle();
                    },
                    buttonname: "Google",
                    Color: Color.fromARGB(255, 211, 27, 27),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "don't have account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("Register");
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
