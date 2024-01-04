import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/util/button_basic.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 180, 158, 240),
      // ignore: sized_box_for_whitespace
      content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter task name',
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                    ),
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ButtonBasic(text: "Save", onPressed: onSave),
                const SizedBox(width: 8),
                ButtonBasic(text: "Cancel", onPressed: onCancel)
              ])
            ],
          )),
    );
  }
}
