import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/widgets.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
                          child: Icon(
                            CupertinoIcons.arrow_left,
                            color: Color(0xFF211551),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter Task Title",
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF211551)),
                        ),
                      )
                    ],
                  ),
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Enter task description",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 24.0)),
                ),
                SizedBox(height: 8),
                TaskWidget(
                  title: "Create database",
                  isDone: false,
                ),
                TaskWidget(
                  title: "Add new task",
                  isDone: true,
                ),
                TaskWidget(
                  title: "Show all tasks",
                  isDone: false,
                ),
                TaskWidget(
                  isDone: true,
                ),
                TaskWidget(
                  isDone: false,
                ),
              ],
            ),
            Positioned(
              bottom: 24.0,
              right: 24.0,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskPage(),
                    ),
                  );
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
            )
          ],
        ),
      ),
    );
  }
}
