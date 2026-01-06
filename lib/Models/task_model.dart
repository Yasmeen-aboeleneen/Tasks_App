class TaskModel {
  final String taskName;
  final String taskDescription;
  final bool ishighPriority;

  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.ishighPriority,
  });
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      ishighPriority: json['ishighPriority'],
    );
  }

  Map<String, dynamic> convertToMap() {
    return {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'ishighPriority': ishighPriority,
    };
  }
}
