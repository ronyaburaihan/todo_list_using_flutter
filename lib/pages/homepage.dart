import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/database_helper.dart';
import 'package:todo_list/models/task_item.dart';
import 'package:todo_list/pages/taskpage.dart';

import '../widgets.dart';

class HomPage extends StatefulWidget {
  const HomPage({Key? key}) : super(key: key);

  @override
  State<HomPage> createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFFF6F6F6),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 24.0, top: 32.0),
                    child: const Image(
                      image: AssetImage("assets/images/ic_app_logo.png"),
                      height: 60.0,
                      width: 60.0,
                    ),
                  ),
                  Expanded(
                    child: FutureBuilder<List<TaskItem>>(
                      initialData: const [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TaskPage(
                                          taskItem: snapshot.data![index]),
                                    ),
                                  ).then((value) => {
                                    setState((){})
                                  });
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data![index].title,
                                  description:
                                      snapshot.data![index].description,
                                ),
                              );
                            },
                            itemCount: snapshot.data!.length,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskPage(
                          taskItem: TaskItem(-1, "", ""),
                        ),
                      ),
                    ).then((value) => {
                          setState(() {}),
                        });
                  },
                  child: Container(
                    height: 55.0,
                    width: 55.0,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF1C991C), Color(0xFF179635)],
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0)),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: const Icon(
                      CupertinoIcons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
