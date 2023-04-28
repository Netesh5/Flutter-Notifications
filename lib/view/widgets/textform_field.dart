import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.formkey,
      required this.hintText});
  final TextEditingController controller;
  final GlobalKey<FormState> formkey;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formkey,
        child: TextFormField(
          maxLines: null,
          decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(),
              hintText: hintText,
              enabledBorder: const OutlineInputBorder()),
          controller: controller,
        ));
  }
}
