import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/services.dart';

class notification extends StatefulWidget {
  @override
  State<notification> createState() => _notificationState();
}

class _notificationState extends State<notification> {
  // getmassege() async {
  //   String? mytoken = await FirebaseMessaging.instance.getToken();
  //   print("=========================================");
  //   print(mytoken);
  // }

  // myrequestpermission() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );

  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     print('User granted permission');
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     print('User granted provisional permission');
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }

  @override
  void initState() {
    //myrequestpermission();
    // getmassege();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
    );
  }
}

getmessaging() async {
  var headersList = {
    'Accept': '*/*',
    'Content-Type': 'application/json',
    'Authorization':
        'key=AAAAj5GcLi4:APA91bFEJ8nD6aRIQ1kA8neee8xZpjNTgbM1Mb4_vmLGWKaYtbbhl1kJg-R766h8pwE1VYzWd6ElMudn4nZY9_dCvItyehah-ae_xfp7Dc-JgH_WEXfdqev978rWPW_PE7FnktLnXyBH'
  };
  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  var body = {
    "to":
        "cq8sgpl2SqisQj5-e6B2C6:APA91bHP8EZPnhuWNRJ7Wo97CELfhCeTgPYTjEwL3ZPF8cKvk9rRlgxZmx0g0kRwbbPaNqaCJrvgG81aNDgZemmJPBcwcPxLBo-9nekUhM-oU3q9ec5VDdrnTzSm0Y0z4CkdnQVj-o-M",
    "notification": {
      "title": "Check this Mobile (title)",
      "body": "Rich Notification testing (body)",
      "mutable_content": true,
      "sound": "Tri-tone"
    }
  };

  var req = http.Request('POST', url);
  req.headers.addAll(headersList);
  req.body = json.encode(body);

  var res = await req.send();
  final resBody = await res.stream.bytesToString();

  if (res.statusCode >= 200 && res.statusCode < 300) {
    print(resBody);
  } else {
    print(res.reasonPhrase);
  }
}
