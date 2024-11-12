import 'package:flutter/material.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final int index; // Pass the index to the widget

  const TaskTile({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return GestureDetector(
        onDoubleTap: () {
          // Toggle the completion of the task on double tap
          taskProvider.toggleTaskCompletion(task.id);
        },
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(
              '${index + 1}', // Display index (task number)
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize
                .min, // Ensures the row takes up only necessary space
            children: [
              // Checkbox for completion
              IconButton(
                icon: Icon(
                  task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
                  color: task.isDone ? Colors.green : null,
                ),
                onPressed: () {
                  taskProvider.toggleTaskCompletion(task.id);
                },
              ),

              // Remove button (trash can icon)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.grey),
                onPressed: () {
                  taskProvider.deleteTask(task.id);
                },
              ),
            ],
          ),
          onTap: () {
            taskProvider
                .toggleTaskCompletion(task.id); // Toggle completion on tap
          },
          onLongPress: () {
            taskProvider.deleteTask(task.id);
          },
        ));
  }
}
