import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:page2/src/core/providers/providers.dart';

class RangeDatePicker extends ConsumerStatefulWidget {
  const RangeDatePicker({super.key});

  @override
  ConsumerState<RangeDatePicker> createState() => _RangeDatePickerState();
}

class _RangeDatePickerState extends ConsumerState<RangeDatePicker> {
  @override
  Widget build(BuildContext context) {
    return _buildCalendarWithActionButtons();
  }

  Widget _buildCalendarWithActionButtons() {
    final config = CalendarDatePicker2Config(
      selectedDayHighlightColor: const Color(0xfff35556),
      calendarType: CalendarDatePicker2Type.range,
      disableModePicker: true,
      selectedRangeHighlightColor: const Color(0xfff35556).withOpacity(0.5),
      selectedRangeDayTextStyle: const TextStyle(
        color: Colors.white,
      ),
      weekdayLabels: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      firstDayOfWeek: 1,
      controlsHeight: 50,
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dayTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      disabledDayTextStyle: const TextStyle(
        color: Colors.grey,
      ),
      selectableDayPredicate: (day) => !day
          .difference(DateTime.now().subtract(const Duration(days: 1)))
          .isNegative,
    );
    return Consumer(
      builder: (context, ref, child) {
        var dateRangeController = ref.watch(rangeDateProvder.notifier);
        var selectedDateRanges = ref.watch(rangeDateProvder);
        return CalendarDatePicker2(
            config: config,
            value: selectedDateRanges,
            onValueChanged: (dates) =>
                dateRangeController.update((state) => dates));
      },
    );
  }

  String formattedDate(DateTime? date) {
    if (date != null) {
      return DateFormat.yMMMMEEEEd().format(date);
    } else {
      return 'No date selected';
    }
  }
}
