// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

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
      child: Text(text),
      color: Theme.of(context).primaryColor,
    );
  }
}
