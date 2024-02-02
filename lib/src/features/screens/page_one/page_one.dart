import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../widgets/dropdown.dart';
import '../../widgets/firstlastname.dart';
import '../../widgets/text_form_field_widget.dart';

class PageOne extends StatefulWidget {
  final String? restorationId;
  const PageOne({
    super.key,
    this.restorationId,
  });

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> with RestorationMixin {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dateTimeController = TextEditingController();
  final _ninController = TextEditingController();
  final _lgaController = TextEditingController();
  final _addressController = TextEditingController();

  final _pageOneFormKey = GlobalKey<FormState>();

  String? selectedGender;
  String? selectState;

  @override

  //logic to get datetime via datetimepicker
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1900),
          lastDate: DateTime(2025),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;

        _dateTimeController.text =
            '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
              const Text('Step 1 Out of 4'),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _pageOneFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        FirstNameLastName(
                            hintText: 'First Name',
                            controller: _firstNameController),
                        const SizedBox(
                          width: 15,
                        ),
                        FirstNameLastName(
                          hintText: 'Last Name',
                          controller: _lastNameController,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormFieldWidget(
                        hintText: 'National Identity Number',
                        controller: _ninController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Missing field';
                          } else if (value.length < 11) {
                            return 'NIN must be 11 Numbers';
                          }
                          return null;
                        },
                        suffixIcon: null),
                    const SizedBox(
                      height: 15,
                    ),
                    AppDropdownInput(
                      hintText: 'Gender',
                      options: const ['Male', 'Female', 'Not Specified'],
                      value: selectedGender,
                      onChanged: (String? value) {
                        setState(() {
                          selectedGender = value!;
                        });
                      },
                      text: 'Gender',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormFieldWidget(
                      suffixIcon: IconButton(
                          onPressed: () {
                            _restorableDatePickerRouteFuture.present();
                          },
                          icon: const Icon(
                            Icons.calendar_month,
                            color: Colors.grey,
                          )),
                      hintText: 'Date of Birth',
                      controller: _dateTimeController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'No Date Selected';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AppDropdownInput(
                      hintText: 'State of Residence',
                      options: const ['Lagos', 'Abuja', 'Others'],
                      value: selectState,
                      onChanged: (String? value) {
                        setState(() {
                          selectState = value!;
                        });
                      },
                      text: 'State of Residence*',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormFieldWidget(
                      suffixIcon: null,
                      hintText: 'Local Government Area of Residence',
                      controller: _lgaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'No Data Selected';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormFieldWidget(
                      suffixIcon: null,
                      hintText: 'Home Address*',
                      controller: _addressController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'No Data Selected';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_pageOneFormKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
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
          )),
        ));
  }
}
