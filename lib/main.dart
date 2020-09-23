import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tapwa/widget/authen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      title: 'Ta PWA',
      debugShowCheckedModeBanner: false,
      home: Authen(),
    );
  }
}
