class Task {
  final String id;
  String title;
  bool isCompleted;
  DateTime? reminderTime;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.reminderTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'reminderTime': reminderTime?.toIso8601String(),
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      isCompleted: json['isCompleted'],
      reminderTime: json['reminderTime'] != null
          ? DateTime.parse(json['reminderTime'])
          : null,
    );
  }
}
