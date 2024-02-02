import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page2/src/core/providers/providers.dart';

// ignore: must_be_immutable
class TimePicker extends ConsumerStatefulWidget {
  int? currentIndex;

  TimePicker({
    super.key,
    required this.currentIndex,
  });

  @override
  ConsumerState<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends ConsumerState<TimePicker> {
  int? defaultStartingIndex;
  int? startIndex;
  int? endIndex;
  List<DateTime?> selectedTimes = [];
  TimeOfDay? timeSelected;

  @override
  Widget build(BuildContext context) {
    final selectedTimes = ref.read(selectedTimesProvider);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.2,
          mainAxisSpacing: 5,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                final currentDateTime = generateDateTime(index);

                // Check if the selected time is after the currently selected time
                if (startIndex == null ||
                    currentDateTime.isAfter(selectedTimes[0]!)) {
                  ref.read(timePickerProvider).updateTime(index);

                  if (startIndex == null || endIndex != null) {
                    // Start a new selection or change the starting time
                    startIndex = index;
                    endIndex = null;
                    selectedTimes[0] = currentDateTime;
                  } else if (endIndex == null) {
                    // If there is a starting time selected and no ending time, select the ending time
                    endIndex = index;
                    selectedTimes[1] = currentDateTime;
                  }

                  timeSelected = TimeOfDay.fromDateTime(currentDateTime);
                } else {
                  // If the selected time is not allowed, reset both starting and ending times
                  startIndex = index;
                  endIndex = null;
                  selectedTimes[0] = currentDateTime;
                  selectedTimes[1] = null;

                  timeSelected = TimeOfDay.fromDateTime(currentDateTime);
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: (startIndex == index)
                    ? const Color(0xfff35556)
                    : (endIndex == index)
                        ? Colors.amber
                        : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  '${index + 9}:00  ${index + 9 > 11 ? "PM" : "AM"}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: (startIndex == index)
                          ? Colors.white
                          : (endIndex == index)
                              ? Colors.white
                              : Colors.grey),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

DateTime generateDateTime(int index) {
  // Calculate the hour based on the index
  int hour = index + 9;

  // Adjust the hour to be in the 24-hour format
  hour = hour >= 9 ? hour : hour + 12;

  // Return the DateTime object with minutes set to 30
  return DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
    hour,
    00,
  );
}
