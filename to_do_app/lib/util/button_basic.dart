// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ButtonBasic extends StatelessWidget {
  final String text;
  VoidCallback onPressed;

  ButtonBasic({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      // ignore: sort_child_properties_last
      child: Text(text,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.white,
                ),
            ),
      color: Theme.of(context).primaryColor,
    );
  }
}
