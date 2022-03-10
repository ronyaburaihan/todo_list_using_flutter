import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final title, description;

  const TaskCardWidget({Key? key, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
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
                fontSize: 20.0),
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
