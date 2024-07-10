// ignore_for_file: camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/component/entercontainers.dart';
import 'package:untitled/edit.dart';
import 'package:untitled/notes/addnote.dart';
import 'package:untitled/notes/editnote.dart';

class Display_note extends StatefulWidget {
  final String categoryid;

  const Display_note({super.key, required this.categoryid});
  @override
  State<Display_note> createState() => _Display_noteState();
}

class _Display_noteState extends State<Display_note> {
  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;

  getdata() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.categoryid)
        .collection("note")
        .get();
    isloading = false;
    data.addAll(querySnapshot.docs);

    setState(() {});
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Display_note"),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  //scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                      child: Card(
                        color: Colors.orange[100],
                        child: ListTile(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Center(
                                    child: SingleChildScrollView(
                                      child: Expanded(
                                        child: AlertDialog(
                                          content: const Text("Choose :"),
                                          actions: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("exit")),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      Edit_Note(
                                                                        note_docid:
                                                                            data[i].id,
                                                                        category_docid:
                                                                            widget.categoryid,
                                                                        old_note:
                                                                            data[i]["note"],
                                                                        old_price:
                                                                            data[i]["price"],
                                                                      )));
                                                    },
                                                    child: const Text("edit")),
                                                TextButton(
                                                    onPressed: () async {
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              "categories")
                                                          .doc(
                                                              widget.categoryid)
                                                          .collection("note")
                                                          .doc(data[i].id)
                                                          .delete();
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  Display_note(
                                                                      categoryid:
                                                                          widget
                                                                              .categoryid)));
                                                    },
                                                    child:
                                                        const Text("delete")),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                          // onLongPress: () async {
                          //   await FirebaseFirestore.instance
                          //       .collection("categories")
                          //       .doc(widget.categoryid)
                          //       .collection("note")
                          //       .doc(data[i].id)
                          //       .delete();
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => Display_note(
                          //           categoryid: widget.categoryid)));
                          // },
                          // onTap: () {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (context) => Edit_Note(
                          //             note_docid: data[i].id,
                          //             category_docid: widget.categoryid,
                          //             old_note: data[i]["note"],
                          //             old_price: data[i]["price"],
                          //           )));
                          // },
                          leading: Text("${data[i]["note"]}"),
                          trailing: Text("${data[i]["price"]}"),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: EnterContainer(
                    Color: Colors.orange,
                    buttonname: "Add Note",
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              Add_Note(docid: widget.categoryid)));
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
