List<int> getAvailableAppointments(
  DateTime selectedDate,
  String start,
  String end,
) {
  // Extract hour from values like "09:00" or "9 AM"
  int startHour = int.parse(start.split(":")[0]);
  int endHour = int.parse(end.split(":")[0]);

  DateTime today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime selected = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

  bool isToday = selected.isAtSameMomentAs(today);

  List<int> availableHours = [];

  for (int i = startHour; i < endHour; i++) {
    if (!isToday) {
      availableHours.add(i);
    } else {
      if (i > DateTime.now().hour) {
        availableHours.add(i);
      }
    }
  }

  return availableHours;
}
