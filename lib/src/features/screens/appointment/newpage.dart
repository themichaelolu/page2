import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:page2/src/features/widgets/calendar_widget.dart';

import 'package:page2/src/core/providers/providers.dart';

import '../../widgets/range_date_picker.dart';
import '../../widgets/time_picker.dart';

class Appointment extends ConsumerStatefulWidget {
  const Appointment({super.key});

  @override
  ConsumerState<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends ConsumerState<Appointment> {
  bool useCalendarWidget = true;
  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Date',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Select:'),
                Switch(
                  activeColor: const Color(0xfff35556),
                  value: useCalendarWidget,
                  onChanged: (value) {
                    setState(() {
                      useCalendarWidget = value;
                    });
                  },
                ),
                Text(useCalendarWidget ? 'One Date' : 'Range of Dates'),
              ],
            ),
            useCalendarWidget
                ? const CalendarWidget()
                : const RangeDatePicker(),
            const Text(
              'Select Hour',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            TimePicker(
              currentIndex: currentIndex,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return showAlertDialog();
                      });
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    color: const Color(0xfff35556),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget showAlertDialog() {
    final pickedDateRange = ref.watch(rangeDateProvder);
    final DateTime? firstDate =
        pickedDateRange.isNotEmpty ? pickedDateRange.first : null;
    final DateTime? secondDate =
        pickedDateRange.isNotEmpty ? pickedDateRange.last : null;
    final pickedDates = ref.watch(dateProvider);
    final pickedTime = ref.watch(selectedTimesProvider);
    final DateTime? pickedDate =
        pickedDates.isNotEmpty ? pickedDates.first : null;

    final DateTime? startTime = pickedTime.isNotEmpty ? pickedTime.first : null;
    final DateTime? endTime = pickedTime.isNotEmpty ? pickedTime.last : null;

    return AlertDialog(
      title: const Text(
        'Appointment Made!',
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            useCalendarWidget
                ? Text('Date: ${formattedDate(pickedDate)}')
                : Text(
                    'Dates: ${formattedDate(firstDate)} to ${formattedDate(secondDate)}',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'Time: ${formattedTimeOfDay(startTime)} to ${formattedTimeOfDay(endTime)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            // Add more content as needed
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
        ),
      ],
    );
  }
}

String formattedDate(DateTime? date) {
  if (date != null) {
    return DateFormat.yMMMMEEEEd().format(date);
  } else {
    return 'No date selected';
  }
}

String formattedTimeOfDay(DateTime? timeOfDay) {
  if (timeOfDay != null) {
    return '${timeOfDay.hour}:${timeOfDay.minute}0 ${timeOfDay.hour < 12 ? 'AM' : 'PM'}';
  } else {
    return 'No time selected';
  }
}
