import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Displayproducts extends StatefulWidget {
  const Displayproducts({super.key, required this.categoryid});
  final String categoryid;

  @override
  State<Displayproducts> createState() => _DisplayproductsState();
}

class _DisplayproductsState extends State<Displayproducts> {
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
          //title: const Text("Display_note"),
          ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                SizedBox(
                  height: 40,
                ),
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
                          leading: Text("${data[i]["note"]}"),
                          trailing: Text("${data[i]["price"]}"),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                  child: Card(
                    color: Colors.white,
                    child: ListTile(
                      title: Text("للطلب الرجاء التواصل واتساب"),
                      subtitle: Text("0969565338"),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
