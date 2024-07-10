import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/component/entercontainers.dart';
import 'package:untitled/component/textformfeild.dart';

class Edit extends StatefulWidget {
  final String docid;
  final String oldname;

  const Edit({
    super.key,
    required this.docid,
    required this.oldname,
  });
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController name = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  editCategary() async {
    if (formstate.currentState!.validate()) {
      await categories.doc(widget.docid).update({'name': name.text});
    }
  }

  @override
  void initState() {
    name.text = widget.oldname;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed("Display");
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Form(
        key: formstate,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 10),
              child: CustomTextForm(
                textfeild: 'Edit',
                mycontroller: name,
                myicon: const Icon(Icons.edit),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            EnterContainer(
              onTap: () {
                editCategary();
                Navigator.of(context).pushReplacementNamed("Display");
              },
              buttonname: "Edit",
              Color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
