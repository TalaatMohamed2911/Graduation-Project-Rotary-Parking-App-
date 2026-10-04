import 'package:flutter/material.dart';

class TextFormdesign extends StatelessWidget {
  final String labeltext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  final bool obscuretext;
  final bool enabled;

  const TextFormdesign(
      {super.key,
      required this.labeltext,
      required this.mycontroller,
      required this.validator,
      required this.obscuretext,
      required this.enabled});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      obscureText: obscuretext,
      controller: mycontroller,
      validator: validator,
      decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: const TextStyle(fontSize: 15, color: Colors.grey),
          contentPadding: const EdgeInsets.all(18),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 192, 190, 190))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 194, 193, 193)))),
    );
  }
}
