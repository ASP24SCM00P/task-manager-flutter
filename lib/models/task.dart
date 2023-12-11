class Task {
  final String id;
  final String title;
  bool isCompleted;  // Remove 'final' here
  final String details;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.details = '',
  });

  // Add a factory method for creating a Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      details: json['details'] ?? '',
    );
  }

  // Add a method for converting Task to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
      'details': details,
    };
  }

  void setCompleted(bool value) {
    isCompleted = value;
  }

  void deleteTask(Function(Task) onDelete) {
    onDelete(this);
  }
}
