class TaskItem {
  final int taskId;
  final String title, description;

  TaskItem(this.taskId, this.title, this.description);

  Map<String, dynamic> toMap() {
    return {
      "taskId": taskId == -1 ? null : taskId,
      "title": title,
      "description": description,
    };
  }
}
