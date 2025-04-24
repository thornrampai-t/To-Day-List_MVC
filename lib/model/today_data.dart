class TodayData {
  final String id;
  final String title;
  final DateTime dayWrite;
  late DateTime? dayComplete;
  bool isCompleted;

  TodayData({
    required this.id,
    required this.title,
    required this.dayWrite,
    required this.dayComplete,
    required this.isCompleted
  });
}
