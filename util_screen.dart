import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:screenshot/screenshot.dart';

import 'screen_crop_image.dart';

// ignore: must_be_immutable
class UtilScreen extends StatelessWidget {
  File img;
  Uint8List? returnImg;

  double red;
  double green;
  double blue;

  double bright;
  double blured;

  int imgRotate;

  ScreenshotController screenshotController = ScreenshotController();

  UtilScreen({

    required this.img,

    required this.red,
    required this.green,
    required this.blue,

    required this.bright,
    required this.blured,

    required this.imgRotate,

    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    // Функция делающая скриншот редактированного изображения
    void _finished() async {
      await screenshotController
          .capture(pixelRatio: 1)
          .then((Uint8List? image) {
        returnImg = image;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CropScreen(img: returnImg)
          )
        );
      });
    }

    _finished();

    return Scaffold(
      body: Column(
        children: [
          Screenshot(
            controller: screenshotController,
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
                  imageFilter: ui.ImageFilter.blur(sigmaX: blured, sigmaY: blured),
                  child: Image.file(img)
                )
              )
            )
          ),
        ],
      ),
    );
  }
}
