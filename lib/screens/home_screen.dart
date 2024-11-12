import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_tile.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List', style: TextStyle(color: Colors.white, fontSize: 24)),
        backgroundColor: Colors.blue,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Field for New Task
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: const InputDecoration(labelText: 'Enter Task'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      taskProvider.addTask(_taskController.text);
                      _taskController.clear();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Task List
            Expanded(
              child: ListView.builder(
                itemCount: taskProvider.tasks.length,
                itemBuilder: (ctx, index) {
                  final task = taskProvider.tasks[index];
                  return TaskTile(
                    task: task,
                    index: index, // Pass the index to the TaskTile widget
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
