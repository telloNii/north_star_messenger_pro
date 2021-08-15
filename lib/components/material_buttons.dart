import 'package:flutter/material.dart';

class MaterialButtons extends StatelessWidget {
  late final VoidCallback onPressed;
  late final String childText;
  late final Color color;
  late final Color textColor;
  MaterialButtons(
      {required this.onPressed,
      required this.color,
      required this.childText,
      required this.textColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 6),
      child: Material(
        elevation: 5.0,
        color: color,
        type: MaterialType.button,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 150.0,
          height: 70.0,
          child: Text(
            childText,
            style: TextStyle(color: textColor, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
