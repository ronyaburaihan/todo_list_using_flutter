import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final title, description;

  const TaskCardWidget({Key? key, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "(Unnamed Task)",
            style: const TextStyle(
                color: Color(0xFF211551),
                fontWeight: FontWeight.bold,
                fontSize: 24.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              description ?? "No description added",
              style: const TextStyle(
                  fontSize: 16.0, color: Color(0xFF868290), height: 1.2),
            ),
          )
        ],
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final title, isDone;

  const TaskWidget({Key? key, this.title, required this.isDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 4.0,
      ),
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          width: 20.0,
          height: 20.0,
          decoration: BoxDecoration(
              color: isDone ? const Color(0xFF7349FE) : Colors.transparent,
              border: isDone
                  ? null
                  : Border.all(color: const Color(0xFF211551), width: 1),
              borderRadius: BorderRadius.circular(6.0)),
          child: Image.asset("assets/images/check_icon.png"),
        ),
        Text(
          title ?? "(Unnamed Task)",
          style: TextStyle(
              color: isDone ? const Color(0xFF211551) : const Color(0xFF86829D),
              fontSize: 16.0,
              fontWeight: isDone ? FontWeight.bold : FontWeight.w500),
        ),
      ]),
    );
  }
}

class NoGlowBehaviour extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
