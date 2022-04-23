import 'dart:typed_data';
import 'dart:ui' as ui;

import 'screen_change_color.dart';
import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'screen_final_image.dart';

import 'styles.dart';

class CropScreen extends StatefulWidget {
  final Uint8List? img;
  const CropScreen({required this.img, Key? key}) : super(key: key);

  @override
  State<CropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends State<CropScreen> {
  final controller = CropController();

  // Функция сохранения обрезанного изображения
  void cropped() async{
    ui.Image croppedByteImg = await controller.croppedBitmap();
    Image croppedImage = await controller.croppedImage();
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FinalScreen(img: croppedImage, byteImg: croppedByteImg,))
    );
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
                ElevatedButton(onPressed: () {cropped();}, child: const Text("Result"), style: myButtonStyle,),
                const SizedBox(height: 14,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangeColorScreen()));
                  }, child: const Text("Back"), style: myButtonStyle,),
              ],
            ),
          ),
    
          const Spacer(),
    
          CropImage(
            gridColor: Colors.cyan,
            image: Image.memory(widget.img!),
            controller: controller,       
          ),
    
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
