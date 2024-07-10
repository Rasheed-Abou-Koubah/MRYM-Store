import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:untitled/component/entercontainers.dart';
import 'package:untitled/edit.dart';
import 'package:untitled/notes/displaynote.dart';

class Display extends StatefulWidget {
  @override
  State<Display> createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  List<QueryDocumentSnapshot> data = [];
  bool isloading = true;

  getdata() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("categories").get();
    isloading = false;
    data.addAll(querySnapshot.docs);

    setState(() {
      // print("dddddddddddddddd");
    });
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
          // title: IconButton(
          //     onPressed: () {
          //       Navigator.of(context).pushReplacementNamed("Add");
          //     },
          //     icon: const Icon(Icons.arrow_back_outlined)
          // )
          ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              //scrollDirection: Axis.vertical,
              //reverse: true,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 40,
                            mainAxisSpacing: 40),
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Display_note(categoryid: data[i].id)));
                        },
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
                                                                    Edit(
                                                                      docid: data[
                                                                              i]
                                                                          .id,
                                                                      oldname:
                                                                          "${data[i]['name']}",
                                                                    )));
                                                  },
                                                  child: const Text("Edit")),
                                              TextButton(
                                                  onPressed: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection(
                                                            "categories")
                                                        .doc(data[0].id)
                                                        .delete();
                                                    await FirebaseStorage
                                                        .instance
                                                        .refFromURL(
                                                            data[0]["image"])
                                                        .delete();
                                                    Navigator
                                                        .pushReplacementNamed(
                                                            context, "Display");
                                                    //
                                                  },
                                                  child: const Text("Delete")),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Text(
                                "${data[i]['name']}",
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                            ),
                            if (data[i]["image"] != "none")
                              Image.network(
                                data[i]["image"],
                                width: 100,
                                height: 100,
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // EnterContainer(
                  //   Color: Colors.blueGrey,
                  //   buttonname: "Delete",
                  //   onTap: () async {
                  //     await FirebaseFirestore.instance
                  //         .collection("categories")
                  //         .doc(data[0].id)
                  //         .delete();
                  //     await FirebaseStorage.instance
                  //         .refFromURL(data[0]["image"])
                  //         .delete();
                  //   },
                  // ),
                ],
              ),
            ),
    );
  }
}
