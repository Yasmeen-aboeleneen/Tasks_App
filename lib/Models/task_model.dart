class TaskModel {
  final String taskName;
  final String taskDescription;
  final bool ishighPriority;

  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.ishighPriority,
  });

  Map<String, dynamic> convertToMap() {
    return {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'ishighPriority': ishighPriority,
    };
  }
}
