import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page2/src/core/providers/providers.dart';

class AppDropdownInput extends ConsumerWidget {
  final String hintText;
  final List<String> options;
  final String? value;
  final String text;

  final void Function(String?)? onChanged;

  const AppDropdownInput({
    super.key,
    required this.hintText,
    this.options = const [],
    required this.value,
    required this.onChanged,
    required this.text,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var darkMode = ref.watch(darkModeProvider);
    return FormField<String>(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an option';
        }
        return null;
      },
      builder: (FormFieldState<String> state) {
        return DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w300,
                color: Color(0xffafa5a6),
              ),
              fillColor: darkMode
                  ? Colors.grey.withOpacity(0.2)
                  : const Color(0xfff1f2f2),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide.none),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an Option';
              }
              return null;
            },
            hint: Text(
              text,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w300,
                fontSize: 17,
              ),
            ),
            value: value,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              color: Color(0xffafa5a6),
              fontSize: 17,
            ),
            icon: const Icon(
              Icons.expand_more,
              color: Color(0xffafa5a6),
            ),
            isDense: true,
            onChanged: onChanged,
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
