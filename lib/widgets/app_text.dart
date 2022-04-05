import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String label;
  final String hint;
  final bool password;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  const AppText(
    this.label,
    this.hint, {
    Key? key,
    this.password = false,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.nextFocus,
    this.textInputAction,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      focusNode: focusNode,
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      style: const TextStyle(
        color: Colors.blue,
      ),
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 16,
          )),
    );
  }
}
