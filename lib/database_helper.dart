import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/task_item.dart';

class DatabaseHelper {
  Future<Database> getDatabase() async {
    return openDatabase(
      join(
        await getDatabasesPath(),
        "todo.db",
      ),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(taskId INTEGER PRIMARY KEY, title TEXT, description TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertTask(TaskItem taskItem) async {
    Database _db = await getDatabase();
    await _db.insert("tasks", taskItem.toMap(),
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
}
