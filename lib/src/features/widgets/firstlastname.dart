import 'package:flutter/material.dart';

import 'text_form_field_widget.dart';

class FirstNameLastName extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const FirstNameLastName({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 55,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.42,
        child: TextFormFieldWidget(
          suffixIcon: null,
          hintText: hintText,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter missing data';
            }
            return null;
          },
        ),
      ),
    );
  }
}
