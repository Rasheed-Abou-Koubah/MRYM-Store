import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/component/entercontainers.dart';
import 'package:untitled/component/textformfeild.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
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
                          textfeild: "username",
                          mycontroller: username,
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
                        textfeild: "email",
                        mycontroller: email,
                        myicon: const Icon(
                          Icons.lock,
                          color: Colors.blueGrey,
                        )),
                  ),
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
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        FirebaseAuth.instance.currentUser!
                            .sendEmailVerification();
                        Navigator.of(context).pushReplacementNamed("login");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    buttonname: "Register",
                    Color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        " have ccount?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("login");
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
