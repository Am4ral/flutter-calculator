import 'package:flutter/material.dart';


class Buttons extends StatelessWidget{
  
  final color;
  final textColor;
  final String buttonText;
  final double textSize = 25;
  final buttonTapped;

  Buttons({this.color,  this.textColor, required this.buttonText, this.buttonTapped});

  
  @override
  Widget build(BuildContext context){
    return GestureDetector(
        onTap: buttonTapped,
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50), 
          child: Container(
            color: color,
            child: Center(child: Text(buttonText, style: TextStyle(color: textColor, fontSize: textSize),),),
          ) 
          ),
        ),
    );
  }
}
