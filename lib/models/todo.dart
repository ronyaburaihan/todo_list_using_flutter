class ToDo {
  final int todoId, taskId, isDone;
  final String title;

  ToDo(this.todoId, this.taskId, this.title, this.isDone);

  Map<String, dynamic> toMap() {
    return {
      "todoId": todoId == -1 ? null : todoId,
      "taskId": taskId,
      "title": title,
      "isDone": isDone,
    };
  }
}
