import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FilterSliders extends StatelessWidget {
  String colorName;

  Color? textColor;

  double editColor, minLen, maxLen;

  final ValueChanged<double> callBack;

  FilterSliders({ Key? key,
    required this.editColor, required this.colorName, 
    required this.callBack, required this.textColor,
    this.minLen = 0, this.maxLen = 1
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            const SizedBox(width: 15),
            Text(colorName, style: const TextStyle(color: Colors.white, fontSize: 20)),
            const Spacer(),
            Text(editColor.toStringAsFixed(3), style: TextStyle(color: textColor, fontSize: 20)),
            const SizedBox(width: 15)
          ],
        ),
        Slider(
          activeColor: Colors.cyan,
          inactiveColor: Colors.cyan[900],
          thumbColor: Colors.white,  
          value: editColor,
          onChanged: callBack,
          label: "$editColor",
          min: minLen,
          max: maxLen,
        ),
      ],
    );
  }
}