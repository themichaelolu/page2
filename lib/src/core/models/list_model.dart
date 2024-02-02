class Doctor {
  String doctorName;
  bool isNearby;
  bool isMidLevel;
  bool isDay;

  Doctor({
    required this.doctorName,
    required this.isNearby,
    required this.isMidLevel,
    required this.isDay,
  });

  static List<Doctor> doctors = [
    Doctor(
        doctorName: 'Doc. Mike',
        isNearby: true,
        isMidLevel: false,
        isDay: true),
    Doctor(
        doctorName: 'Doc. S', isNearby: true, isMidLevel: false, isDay: true),
    Doctor(
      doctorName: 'Doc. Boy',
      isNearby: true,
      isMidLevel: false,
      isDay: false,
    ),
    Doctor(
      doctorName: 'Doc. This',
      isNearby: false,
      isMidLevel: true,
      isDay: true,
    ),
    Doctor(
      doctorName: 'Doc. That',
      isNearby: true,
      isMidLevel: false,
      isDay: true,
    ),
  ];
}
