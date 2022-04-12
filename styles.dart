import 'package:flutter/material.dart';

final ButtonStyle openButtonStyle = 
  ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 12), 
    primary: const Color.fromARGB(255, 64, 64, 64),
    fixedSize: const Size(64, 64),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90), side: const BorderSide(color: Colors.cyan, width: 2)),
  );