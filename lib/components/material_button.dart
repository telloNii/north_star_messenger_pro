import 'package:flutter/material.dart';

class MaterialButtons extends StatelessWidget {
  late final VoidCallback onPressed;
  late final String childText;
  late final Color color;
  MaterialButtons(
      {required this.onPressed, required this.color, required this.childText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            childText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
