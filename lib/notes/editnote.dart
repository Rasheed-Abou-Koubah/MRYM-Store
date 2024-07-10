import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/component/entercontainers.dart';
import 'package:untitled/component/textformfeild.dart';
import 'package:untitled/notes/displaynote.dart';

class Edit_Note extends StatefulWidget {
  final String note_docid;
  final String category_docid;
  final String old_note;
  final String old_price;

  const Edit_Note(
      {super.key,
      required this.note_docid,
      required this.category_docid,
      required this.old_note,
      required this.old_price});
  @override
  State<Edit_Note> createState() => _Edit_NoteState();
}

class _Edit_NoteState extends State<Edit_Note> {
  TextEditingController note = TextEditingController();
  TextEditingController price = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  editNotes() async {
    CollectionReference collection_note = FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.category_docid)
        .collection("note");
    if (formstate.currentState!.validate()) {
      setState(() {});
      await collection_note
          .doc(widget.note_docid)
          .update({"note": note.text, "price": price.text});
      // "id": FirebaseAuth.instance.currentUser!.uid
    }
  }

  @override
  void initState() {
    note.text = widget.old_note;
    price.text = widget.old_price;
    super.initState();
  }
  // void dispose() {
  //   super.dispose();
  //   note.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit_Note"),
      ),
      body: Form(
        key: formstate,
        child: Column(
          children: [
            CustomTextForm(
              textfeild: 'Edit Note',
              mycontroller: note,
              myicon: const Icon(Icons.edit),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextForm(
              textfeild: 'Edit Note',
              mycontroller: price,
              myicon: const Icon(Icons.edit),
            ),
            const SizedBox(
              height: 10,
            ),
            EnterContainer(
              onTap: () {
                editNotes();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Display_note(
                          categoryid: widget.category_docid,
                        )));
              },
              buttonname: "Edit Note",
              Color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
