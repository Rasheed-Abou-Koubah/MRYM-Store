import 'package:flutter/material.dart';

class EnterContainer extends StatelessWidget {
  final buttonname;
  final Color;
  final void Function()? onTap;

  const EnterContainer({
    super.key,
    this.buttonname,
    this.Color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          width: 260,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Color),
          child: Center(
              child: Text(
            buttonname,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
        ));
  }
}
