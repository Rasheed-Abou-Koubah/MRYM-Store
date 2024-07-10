import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/component/entercontainers.dart';

class Pickimage extends StatefulWidget {
  @override
  State<Pickimage> createState() => _PickimageState();
}

class _PickimageState extends State<Pickimage> {
  File? file;

  getimage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("اضافة صورة"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 90, 30, 50),
            child: Center(
              child: EnterContainer(
                Color: Colors.orange,
                buttonname: "اختيار صورة",
                onTap: () async {
                  await getimage();
                },
              ),
            ),
          ),
          if (file != null)
            Center(
              child: Image.file(
                file!,
              ),
            ),
        ],
      ),
    );
  }
}
