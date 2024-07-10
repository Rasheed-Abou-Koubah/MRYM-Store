import 'package:flutter/material.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Card(
                color: Colors.orange[100],
                child: const ListTile(
                  title: Text("لطلب أي منتج الرجاء التواصل على واتساب"),
                  subtitle: Text(" 0969565338"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
