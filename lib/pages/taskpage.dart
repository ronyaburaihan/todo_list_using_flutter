import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/database_helper.dart';
import 'package:todo_list/models/task_item.dart';
import 'package:todo_list/models/todo.dart';

import '../widgets.dart';

class TaskPage extends StatefulWidget {
  final TaskItem taskItem;

  const TaskPage({
    Key? key,
    required this.taskItem,
  }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  String _taskTitle = "";
  String _taskDescription = "";
  String _toDoText = "";
  int _taskId = -1;

  late FocusNode _titleFocus, _descriptionFocus, _todoFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    print("Task id: ${widget.taskItem.taskId}");
    if (widget.taskItem.taskId != -1) {
      _taskId = widget.taskItem.taskId;
      _taskTitle = widget.taskItem.title;
      _taskDescription = widget.taskItem.description;

      _contentVisible = true;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            CupertinoIcons.arrow_left,
                            color: Color(0xFF211551),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: _titleFocus,
                          onSubmitted: (value) async {
                            if (value != "") {
                              if (_taskId == -1) {
                                _taskId = await _dbHelper
                                    .insertTask(TaskItem(_taskId, value, ""));
                                print("Task created, TaskId: $_taskId");
                                setState(() {
                                  _contentVisible = true;
                                  _taskTitle = value;
                                });
                              } else {
                                await _dbHelper.updateTaskTitle(_taskId, value);
                              }
                            }
                            _descriptionFocus.requestFocus();
                          },
                          controller: TextEditingController()
                            ..text = _taskTitle,
                          decoration: const InputDecoration(
                            hintText: "Enter Task Title",
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF211551)),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: TextField(
                    focusNode: _descriptionFocus,
                    onSubmitted: (value) async {
                      if (value != "" && _taskId != -1) {
                        print("Task description added in taskId: $_taskId");
                        await _dbHelper.updateTaskDescription(_taskId, value);
                        _taskDescription = value;
                      }
                      _todoFocus.requestFocus();
                    },
                    decoration: const InputDecoration(
                        hintText: "Enter task description",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 24.0)),
                    controller: TextEditingController()
                      ..text = _taskDescription,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: FutureBuilder<List<ToDo>>(
                    initialData: const [],
                    future: _dbHelper.getToDos(_taskId),
                    builder: (context, snapshot) {
                      return ScrollConfiguration(
                        behavior: NoGlowBehaviour(),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                print(
                                    "Task done ${snapshot.data![index].todoId}");
                                await _dbHelper.updateToDoStatus(
                                    snapshot.data![index].todoId,
                                    snapshot.data![index].isDone == 0 ? 1 : 0);
                                setState(() {});
                              },
                              child: TaskWidget(
                                title: snapshot.data![index].title,
                                isDone: snapshot.data![index].isDone == 0
                                    ? false
                                    : true,
                              ),
                            );
                          },
                          itemCount: snapshot.data!.length,
                        ),
                      );
                    },
                  ),
                ),
                Visibility(
                  visible: _contentVisible,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                  color: const Color(0xFF211551), width: 1),
                              borderRadius: BorderRadius.circular(6.0)),
                          child: Image.asset("assets/images/check_icon.png"),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _todoFocus,
                            controller: TextEditingController()..text = _toDoText,
                            onSubmitted: (value) async {
                              if (value != "" && _taskId != -1) {
                                ToDo _todo = ToDo(-1, _taskId, value, 0);
                                await _dbHelper.insertTodo(_todo);
                                print("Todo created, Task Id: ${_taskId}");
                                setState(() {
                                  _toDoText = "";
                                });
                                _todoFocus.requestFocus();
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Enter todo item",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Visibility(
              visible: _contentVisible,
              child: Positioned(
                bottom: 24.0,
                right: 24.0,
                child: InkWell(
                  onTap: () async {
                    if (_taskId != -1) {
                      await _dbHelper.deleteTask(_taskId);
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    height: 55.0,
                    width: 55.0,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFE3577),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Icon(
                      CupertinoIcons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
