import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String textfeild;
  final TextEditingController mycontroller;
  final Icon myicon;
  const CustomTextForm({
    super.key,
    required this.textfeild,
    required this.mycontroller,
    required this.myicon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        controller: mycontroller,
        style: const TextStyle(fontSize: 15),
        //textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: EdgeInsetsDirectional.only(
                start: 15, end: 10, bottom: 5, top: 5),
            labelText: textfeild,
            suffix: myicon,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }
}
