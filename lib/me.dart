import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/aboutus.dart';
import 'package:untitled/component/email.dart';
import 'package:untitled/displayproducts.dart';
import 'package:untitled/questions.dart';

class me extends StatefulWidget {
  @override
  State<me> createState() => _meState();
}

class _meState extends State<me> {
  List<QueryDocumentSnapshot> products = [];
  bool isloading = true;

  getproducts() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("categories").get();
    isloading = false;
    products.addAll(querySnapshot.docs);

    setState(() {});
  }

  @override
  void initState() {
    getproducts();
    super.initState();
  }

  @override
  String e = StoreEmail.getEmail().toString();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //backgroundColor: Colors.blue[100],
          drawer: Drawer(
            backgroundColor: Colors.blue[50],
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    if (e == "y9697710@gmail.com" ||
                        e == "rasheedaboyaman@gmail.com") {
                      Navigator.of(context).pushReplacementNamed("Add");
                    }
                  },
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("MRYM"),
                    subtitle: Text(e),
                  ),
                ),
                const Divider(),
                // const ListTile(
                //   leading: Icon(Icons.monetization_on),
                //   title: Text("Balance"),
                // ),
                // const ListTile(
                //   leading: Icon(Icons.history),
                //   title: Text("History"),
                // ),
                // const ListTile(
                //   leading: Icon(Icons.help_outline_sharp),
                //   title: Text("Support"),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Questions()));
                  },
                  child: const ListTile(
                    leading: Icon(Icons.question_answer_sharp),
                    title: Text("Questions"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Aboutus()));
                  },
                  child: const ListTile(
                    leading: Icon(Icons.people),
                    title: Text("About us"),
                  ),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  Navigator.of(context).pushReplacementNamed("login");
                },
                child: Text("تسجيل خروج"),
              )
            ],
          ),
          body: Column(
            children: [
              Container(
                //height: 100,
                color: Colors.white,
                child: Image.asset("assets/images/logonew.png"),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(40, 60, 40, 20),
                  height: 100,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 241, 240, 238),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(90),
                          topRight: Radius.circular(90))),
                  child: GridView.builder(
                    //physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 30),
                    itemCount: products.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Displayproducts(categoryid: products[i].id)));
                        },
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Text(
                                "${products[i]['name']}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    backgroundColor: Colors.grey[200]),
                              ),
                            ),
                            if (products[i]["image"] != "none")
                              Image.network(
                                products[i]["image"],
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
