import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/pages/taskpage.dart';
import 'package:todo_list/widgets.dart';

class HomPage extends StatefulWidget {
  const HomPage({Key? key}) : super(key: key);

  @override
  State<HomPage> createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
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
                      image: AssetImage("assets/images/logo.png"),
                    ),
                  ),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: NoGlowBehaviour(),
                      child: ListView(
                        children: [
                          TaskCardWidget(
                            title: "Get Started",
                            description:
                                "Welcome to Todo List application. Here you can add and view your task easily",
                          ),
                          TaskCardWidget(),
                          TaskCardWidget(),
                          TaskCardWidget(),
                          TaskCardWidget(),
                          TaskCardWidget(),
                          TaskCardWidget(),
                          TaskCardWidget(),
                        ],
                      ),
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
                        builder: (context) => TaskPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 55.0,
                    width: 55.0,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xFF7349FE), Color(0xFF643FDB)],
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
