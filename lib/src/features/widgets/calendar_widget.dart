import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page2/src/core/providers/providers.dart';

class CalendarWidget extends ConsumerStatefulWidget {
  const CalendarWidget({super.key});

  @override
  ConsumerState<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends ConsumerState<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildDefaultSingleDatePickerWithValue();
  }

  Widget _buildDefaultSingleDatePickerWithValue() {
    var darkMode = ref.watch(darkModeProvider);
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: const Color(0xfff35556),
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: TextStyle(
        color: darkMode ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
      yearTextStyle: TextStyle(
        color: darkMode ? Colors.white : Colors.black,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: TextStyle(
        color: darkMode ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: TextStyle(
        color: Colors.grey,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 1)))
          .isNegative,
    );
    return Consumer(builder: (context, ref, child) {
      var dateController = ref.watch(dateProvider.notifier);
      var selectedDate = ref.watch(dateProvider);

      return Column(
        children: [
          CalendarDatePicker2(
              config: config,
              value: selectedDate,
              onValueChanged: (dates) {
                dateController.update((state) => dates);
              }),
        ],
      );
    });
  }
}
