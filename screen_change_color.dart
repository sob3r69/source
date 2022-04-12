import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';

import 'util_screen.dart' as uti;
import 'edit_sliders.dart';
import 'styles.dart';

class ChangeColorScreen extends StatefulWidget {
  const ChangeColorScreen({ Key? key }) : super(key: key);

  @override
  State<ChangeColorScreen> createState() => _ChangeColorScreenState();
}

class _ChangeColorScreenState extends State<ChangeColorScreen> {
  File imgFile = File("assets/images/Eblo.jpg");
  Uint8List? returnImg;

  double red = 1;
  double green = 1;
  double blue = 1;

  double bright = 1;
  double blured = 0;

  int imgRotate = 0;

  void _pickFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File _selectedFile = File(result.files.single.path!);
      setState(() {
        imgFile = _selectedFile;
      });
    }
  }

  void _finished() async{
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => uti.UtilScreen(
        img: imgFile,
        red: red, green: green, blue: blue,
        bright: bright, blured: blured,
        imgRotate: imgRotate
        )
      )
    );
  }

  void _resetToDefault(){
    setState(() {
      red = 1;
      green = 1;
      blue = 1;
      bright = 1;
      blured = 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _pickFile, child: Image.asset("assets/icons/folder_out.png"), style: openButtonStyle,),
                const SizedBox(height: 14,),
                ElevatedButton(
                  onPressed: _finished,
                  child: const Icon(Icons.crop), style: openButtonStyle),
              ],
            ),
          ),

          Expanded(            
            child: InteractiveViewer(
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix([
                  red * bright, 0, 0, 0, 0,
                  0, green * bright, 0, 0, 0,
                  0, 0, blue * bright, 0, 0,
                  0, 0, 0, 1, 0,
                ]),
                child: RotatedBox(
                  quarterTurns: imgRotate,
                  child: ImageFiltered(
                    imageFilter: ui.ImageFilter.blur(sigmaX: blured, sigmaY: blured, tileMode: ui.TileMode.decal),
                    child: Image.file(imgFile),
                  ),
                ),
              ),
            ),
          ),

          Container(
            decoration: const BoxDecoration(color: Color.fromARGB(255, 51, 51, 51)),
            width: 280,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: _resetToDefault, icon: const Icon(Icons.restore), color: Colors.white),
                EditSliders(editColor: red, colorName: "Red", callBack: (double newColor) {setState((){red = newColor;});},
                 textColor: Colors.red),
                
                EditSliders(editColor: green, colorName: "Green", callBack: (double newColor) {setState((){green = newColor;});},
                 textColor: Colors.green),

                EditSliders(editColor: blue, colorName: "Blue", callBack: (double newColor) {setState((){blue = newColor;});},
                 textColor: Colors.blue[300]),

                EditSliders(editColor: bright, colorName: "Brightness", callBack: (double newColor) {setState((){bright = newColor;});},
                 textColor: Colors.white, maxLen: 2,),

                EditSliders(editColor: blured, colorName: "Blur", callBack: (double newColor) {setState((){blured = newColor;});},
                 textColor: Colors.white, maxLen: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () {setState((){imgRotate -= 1;});}, child: const Icon(Icons.rotate_left), style: openButtonStyle,),
                    ElevatedButton(onPressed: () {setState((){imgRotate += 1;});}, child: const Icon(Icons.rotate_right), style: openButtonStyle,),
                  ],
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}