import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/task_item.dart';
import 'package:todo_list/models/todo.dart';

class DatabaseHelper {
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), "todo.db"),
      onCreate: (db, version) async {
        await db.execute(
            "CREATE TABLE tasks(taskId INTEGER PRIMARY KEY, title TEXT, description TEXT)");
        return await db.execute(
            "CREATE TABLE todo(todoId INTEGER PRIMARY KEY, taskId INTEGER, title TEXT, isDone INTEGER)");
      },
      version: 1,
    );
  }

  Future<int> insertTask(TaskItem taskItem) async {
    int taskId = 0;
    Database _db = await getDatabase();
    await _db
        .insert("tasks", taskItem.toMap(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) => taskId = value);
    return taskId;
  }

  Future<void> updateTaskTitle(int taskId, String title) async {
    Database _db = await getDatabase();
    await _db.rawUpdate(
        "UPDATE tasks SET title = '$title' WHERE taskId = '$taskId'");
  }

  Future<void> updateTaskDescription(int taskId, String description) async {
    Database _db = await getDatabase();
    await _db.rawUpdate(
        "UPDATE tasks SET description = '$description' WHERE taskId = '$taskId'");
  }

  Future<void> deleteTask(int taskId) async {
    Database _db = await getDatabase();
    await _db.rawDelete("DELETE FROM tasks WHERE taskId = '$taskId'");
    await _db.rawDelete("DELETE FROM todo WHERE taskId = '$taskId'");
  }

  Future<void> updateToDoStatus(int todoId, int isDone) async {
    Database _db = await getDatabase();
    await _db.rawUpdate(
        "UPDATE todo SET isDone = '$isDone' WHERE todoId = '$todoId'");
  }

  Future<void> insertTodo(ToDo toDo) async {
    Database _db = await getDatabase();
    await _db.insert("todo", toDo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<TaskItem>> getTasks() async {
    Database _db = await getDatabase();
    List<Map<String, dynamic>> taskMap = await _db.query("tasks");
    return List.generate(
      taskMap.length,
      (index) => TaskItem(
        taskMap[index]["taskId"],
        taskMap[index]["title"],
        taskMap[index]["description"],
      ),
    );
  }

  Future<List<ToDo>> getToDos(int taskId) async {
    Database _db = await getDatabase();
    List<Map<String, dynamic>> todoMap =
        await _db.rawQuery("SELECT * FROM todo WHERE taskId = $taskId");
    return List.generate(
      todoMap.length,
      (index) => ToDo(
        todoMap[index]["todoId"],
        todoMap[index]["taskId"],
        todoMap[index]["title"],
        todoMap[index]["isDone"],
      ),
    );
  }
}
