import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page2/src/core/providers/providers.dart';

class TextFormFieldWidget extends ConsumerStatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  const TextFormFieldWidget(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.validator,
      required this.suffixIcon});

  @override
  ConsumerState<TextFormFieldWidget> createState() =>
      _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends ConsumerState<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    var darkMode = ref.watch(darkModeProvider);
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      decoration: InputDecoration(
          suffixIcon: widget.suffixIcon,
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          fillColor:
              darkMode ? Colors.grey.withOpacity(0.2) : const Color(0xfff1f2f2),
          filled: true,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w300,
            color: Color(0xffafa5a6),
          )),
    );
  }
}
