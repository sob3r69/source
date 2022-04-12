import 'package:flutter/material.dart';

import 'screen_change_color.dart';

void main(List<String> args) {
  runApp(const OpenImageApp());
}

class OpenImageApp extends StatelessWidget {
  const OpenImageApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Photo Editor",
      debugShowCheckedModeBanner: false,
      home: const ChangeColorScreen(),
      theme: ThemeData(scaffoldBackgroundColor: const Color.fromARGB(255, 64, 64, 64)),
    );
  }
}