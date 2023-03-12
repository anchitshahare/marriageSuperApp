class Task {
  String? taskName;
  String? taskDetails;
  String? pickedDate;
  bool? status;

  Task({
    required this.taskName,
    required this.taskDetails,
    required this.pickedDate,
    this.status = false,
  });
}
