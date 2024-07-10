import 'dart:io';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RealTime extends StatefulWidget {
  @override
  State<RealTime> createState() => _RealTimeState();
}

class _RealTimeState extends State<RealTime> {
  // final Stream<QuerySnapshot> _usersStream =
  //     FirebaseFirestore.instance.collection('users').snapshots();
  File? file;
  String? url;

  get_image() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    //final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) file = File(photo!.path);

    var imagename = basename(photo!.path);
    var refstorage = FirebaseStorage.instance.ref(imagename);
    await refstorage.putFile(file!);

    url = await refstorage.getDownloadURL();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Real Time"),
      ),
      body: Column(
        children: [
          // Container(
          //     child: StreamBuilder(
          //         stream: _usersStream,
          //         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //           if (snapshot.hasError) {
          //             return Text('Something went wrong');
          //           }

          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return Text("Loading");
          //           }
          //           return ListView.builder(
          //             itemCount: snapshot.data?.docs.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               return InkWell(
          //                 child: Card(
          //                   child: ListTile(
          //                     subtitle:
          //                         Text("${snapshot.data!.docs[index]['age']}"),
          //                     title:
          //                         Text("${snapshot.data!.docs[index]['name']}"),
          //                   ),
          //                 ),
          //               );
          //             },
          //           );
          //         })),
          MaterialButton(
            onPressed: () async {
              await get_image();
              setState(() {});
            },
            color: const Color.fromARGB(255, 180, 165, 165),
            child: Text("Get Image"),
          ),
          SizedBox(
            height: 30,
          ),
          // if (file != null)
          //   Image.file(
          //     file!,
          //     width: 50,
          //     height: 50,
          //   ),
          SizedBox(
            height: 30,
          ),
          if (url != null) Image.network(url!),
        ],
      ),
    );
  }
}
