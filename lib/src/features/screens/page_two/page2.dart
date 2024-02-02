import 'package:flutter/material.dart';

import '../../widgets/dropdown.dart';
import '../../widgets/text_form_field_widget.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  String? selectedSpecialization;
  String? selectedSubSpecialization;
  String? yearsOfExperience; // Initialize with a default value

  final _medicalController = TextEditingController();
  final _page2FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Step 2 Out of 4'),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _page2FormKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      suffixIcon: null,
                      hintText: 'Medical License Number*',
                      controller: _medicalController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Medical License Number Missing';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AppDropdownInput(
                      hintText: 'Specialization',
                      options: const ['Surgery', 'Paediatrics', 'Others'],
                      value: selectedSpecialization,
                      onChanged: (String? value) {
                        setState(() {
                          selectedSpecialization = value!;
                        });
                      },
                      text: 'Specialization*',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AppDropdownInput(
                      hintText: 'Sub-Specialization*',
                      options:
                          const {'Surgery', 'Paediatrics', 'Others'}.toList(),
                      value: selectedSubSpecialization,
                      onChanged: (String? value) {
                        setState(() {
                          selectedSubSpecialization = value!;
                        });
                      },
                      text: 'Sub-Specialization*',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormFieldWidget(
                      hintText: 'Board Ceritifications*',
                      controller: _medicalController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Board Certification Missing';
                        }
                        return null;
                      },
                      suffixIcon: null,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AppDropdownInput(
                      hintText: 'Years of Experience*',
                      options: const ['1+', '5+', '10+'],
                      value: yearsOfExperience,
                      onChanged: (String? value) {
                        setState(() {
                          yearsOfExperience = value!;
                        });
                      },
                      text: 'Years of Experience*',
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              GestureDetector(
                onTap: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_page2FormKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xfff35556),
                  ),
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
