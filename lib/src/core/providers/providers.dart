import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

int? currentIndex;
DateTime? time;

final dateProvider = StateProvider<List<DateTime?>>((ref) {
  return [DateTime.now()];
});
final dateSelectedProvider = StateProvider<DateTime?>(
  (ref) {
    return null;
  },
);

final rangeDateProvder = StateProvider<List<DateTime?>>((ref) {
  return [
    DateTime.now(),
    DateTime.now().add(Duration.zero),
  ];
});
final dateRangeSelectedProvider = StateProvider<DateTime?>((ref) {
  return null;
});

final timePickerProvider =
    ChangeNotifierProvider<TimePickerState>((ref) => TimePickerState());

class TimePickerState extends ChangeNotifier {
  int? currentIndex;
  TimeOfDay? timeSelected;
  void updateTime(int index) {
    currentIndex = index;

    // Calculate the corresponding DateTime

    // Notify listeners that the state has changed
    notifyListeners();
  }
}

final selectedTimesProvider = Provider<List<DateTime?>>((ref) => [null, null]);

class DarkModeProvider extends StateNotifier<bool> {
  DarkModeProvider() : super(false);

  void toggle() {
    state = !state;
  }
}

final darkModeProvider = StateNotifierProvider<DarkModeProvider, bool>(
  (ref) => DarkModeProvider(),
);
