import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'styles.dart';

class FinalScreen extends StatelessWidget {
  final ui.Image byteImg;
  final Image img;

  const FinalScreen({required this.img, required this.byteImg, Key? key}) : super(key: key);

  // Функция изображения изображения
  void _saveFile() async{
    Directory docDir = await getApplicationDocumentsDirectory();
    String? docPath = docDir.path;

    String? outputFile = await FilePicker.platform.saveFile(initialDirectory: docPath, type: FileType.custom, allowedExtensions: ['png']);

    if (outputFile == null) return;

    var pngBytes = await byteImg.toByteData(format: ui.ImageByteFormat.png);
    File('$outputFile.png').writeAsBytesSync(pngBytes!.buffer.asInt8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _saveFile, child: const Text("Save"), style: myButtonStyle,),
                const SizedBox(height: 14,),
                ElevatedButton(onPressed: () {Navigator.pop(context);}, child: const Text("Back"), style: myButtonStyle,),
              ],
            ),
          ),
          Expanded(child: InteractiveViewer(child: img)),
        ],
      ),
    );
  }
}