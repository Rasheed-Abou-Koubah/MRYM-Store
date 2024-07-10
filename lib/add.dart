import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/component/entercontainers.dart';
import 'package:untitled/component/textformfeild.dart';

class Add extends StatefulWidget {
  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController name = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  File? file;
  String? url;
  bool choosen = false;

  getimage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
    }
    var imagename = basename(image!.path);
    var refstorage = FirebaseStorage.instance.ref("Images").child(imagename);

    await refstorage.putFile(file!);

    url = await refstorage.getDownloadURL();

    setState(() {});
  }

  addCategary() async {
    if (formstate.currentState!.validate() && name.text != "") {
      try {
        DocumentReference response = await categories.add({
          "name": name.text,
          "image": url ?? "none",
          // "id": FirebaseAuth.instance.currentUser!.uid
        });
      } catch (e) {
        print("==============================$e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: IconButton(
        //     onPressed: () {
        //       Navigator.of(context).pushReplacementNamed("me");
        //     },
        //     icon: const Icon(Icons.arrow_back)),
        actions: [
          TextButton(
            child: const Text("Products"),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("Display");
            },
          ),
        ],
      ),
      body: Form(
        key: formstate,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 10),
              child: CustomTextForm(
                textfeild: 'Name',
                mycontroller: name,
                myicon: const Icon(
                  Icons.add_card_rounded,
                  color: Colors.orange,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                await getimage();
              },
              child: Container(
                //margin: const EdgeInsets.fromLTRB(15, 20, 40, 15),
                alignment: Alignment.topCenter,
                child: const Text(
                  "Choose Image",
                  style: TextStyle(
                      fontSize: 16, decoration: TextDecoration.underline),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            if (file != null)
              Center(
                child: Image.file(
                  file!,
                  width: 125,
                  height: 125,
                ),
              ),
            const SizedBox(
              height: 15,
            ),
            EnterContainer(
              onTap: () {
                //choosen = true;
                addCategary();
                Navigator.of(context).pushReplacementNamed("Display");
              },
              buttonname: "Add",
              Color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}
