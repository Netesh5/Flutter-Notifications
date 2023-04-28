import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String content) {
  final snackBar = SnackBar(
    content: Text(content),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
