import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/component/entercontainers.dart';
import 'package:untitled/component/textformfeild.dart';
import 'package:untitled/notes/displaynote.dart';

class Add_Note extends StatefulWidget {
  final String docid;

  const Add_Note({super.key, required this.docid});
  @override
  State<Add_Note> createState() => _Add_NoteState();
}

class _Add_NoteState extends State<Add_Note> {
  TextEditingController note = TextEditingController();
  TextEditingController price = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  addNotes() async {
    CollectionReference collection_note = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.docid)
        .collection("note");
    if (formstate.currentState!.validate()) {
      DocumentReference response = await collection_note.add({
        "note": note.text,
        "price": price.text,

        // "id": FirebaseAuth.instance.currentUser!.uid
      });
    }
  }

  // void dispose() {
  //   super.dispose();
  //   note.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add_Note"),
      ),
      body: Form(
        key: formstate,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
              child: CustomTextForm(
                textfeild: 'Add Note',
                mycontroller: note,
                myicon: const Icon(Icons.add),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
              child: CustomTextForm(
                textfeild: 'Add Price',
                mycontroller: price,
                myicon: const Icon(Icons.add),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            EnterContainer(
              onTap: () {
                addNotes();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Display_note(
                          categoryid: widget.docid,
                        )));
              },
              buttonname: "Add Note",
              Color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
