import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  const Questions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: const Icon(Icons.arrow_back_outlined)),
          ),
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
                  title: Text(" هل أستطيع الحصول على أسعار أفضل"),
                  subtitle: Text("بالتأكيد كلما زادت مشترياتك من تطبيقنا"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Card(
                color: Colors.orange[100],
                child: const ListTile(
                  title: Text(" أحتاج حدمة ولا أجدها في التطبيق "),
                  subtitle:
                      Text("  تواصل معنا و أطلعنا عليها لكي نوفرها لاحقا "),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
              child: Card(
                color: Colors.orange[100],
                child: const ListTile(
                  title: Text(" في أي محيط يبحر هذا التطبيق "),
                  subtitle: Text("في كل أنواع الخدمات التقنية"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
