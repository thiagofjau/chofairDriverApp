import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class ProgressDialog extends StatelessWidget {

  String? message;
  ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(205, 255, 255, 255), //branco transparente
      child: Container(
        margin: const EdgeInsets.all(16.0),
        // decoration: BoxDecoration(
        //   color: const Color.fromARGB(255, 95, 95, 95),
        //   borderRadius: BorderRadius.circular(6),
        // ),
        child: Padding(padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
             const SizedBox(width: 6.0),
             const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF222222)),
             ),
             const SizedBox(width: 22.0),
            Text(message!,
              style: const TextStyle(
                color: Color.fromARGB(255, 36, 36, 36), //cor escura dialog
                fontSize: 12,
              ),
            ),
          ],
        )),
      ),
    );
  }
}