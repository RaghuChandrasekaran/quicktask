import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {
final String taskName;
final bool taskCompleted;
final Function(bool?)? onChanged;

  const ToDoTile({super.key, required this.taskName , required this.taskCompleted , required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              Checkbox(value: taskCompleted, onChanged: onChanged),
              Text(taskName, style: TextStyle(decoration: taskCompleted? TextDecoration.lineThrough: TextDecoration.none),),
            ],
          ),
        ));
  }
}