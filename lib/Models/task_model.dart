class TaskModel {
  final String taskName;
  final String taskDescription;
  final bool ishighPriority;
  bool isDone;

  TaskModel({
    required this.taskName,
    required this.taskDescription,
    this.ishighPriority = false,
    this.isDone = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskName: json['taskName'] ?? '',
      taskDescription: json['taskDescription'] ?? '',
      ishighPriority: json['ishighPriority'] ?? false,
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> convertToMap() {
    return {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'ishighPriority': ishighPriority,
      'isDone': isDone,
    };
  }
}