import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  // Load tasks from SharedPreferences
  Future<void> loadTasks() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final taskData = sharedPrefs.getString('task_list');

    if (taskData != null) {
      final List<dynamic> taskList = json.decode(taskData);
      _tasks = taskList.map((taskJson) => Task.fromJson(taskJson)).toList();
      notifyListeners();
    }
  }

  // Save tasks to SharedPreferences
  Future<void> saveTasks() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final taskData = _tasks.map((task) => task.toJson()).toList();
    sharedPrefs.setString('task_list', json.encode(taskData));
  }

  // Add a new task
  Future<void> addTask(String title) async {
    final newTask = Task(id: DateTime.now().toString(), title: title);
    _tasks.add(newTask);
    await saveTasks();
    notifyListeners();
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(String id) async {
    final taskIdx = _tasks.indexWhere((t) => t.id == id);
    if (taskIdx >= 0) {
      _tasks[taskIdx].isDone = !_tasks[taskIdx].isDone;
      await saveTasks();
      notifyListeners();
    }
  }

  // Delete a task
  Future<void> deleteTask(String id) async {
    _tasks.removeWhere((t) => t.id == id);
    await saveTasks();
    notifyListeners();
  }
}
