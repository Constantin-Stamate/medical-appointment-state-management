import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(
        child: Icon(Icons.edit_outlined, size: 19, color: Colors.white),
      ),
    );
  }
}