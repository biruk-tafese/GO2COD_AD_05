import 'package:flutter/material.dart';
import '../data/local/task_repository.dart';
import '../data/models/task_model.dart';

class TasksController with ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  List<Task> tasks = [];

  TasksController() {
    _loadTasks();
  }

  void _loadTasks() async {
    tasks = await _repository.loadTasks();
    notifyListeners();
  }

  void addTask(Task task) {
    tasks.add(task);
    _repository.saveTasks(tasks);
    notifyListeners();
  }

  void editTask(Task task, String newTitle) {
    task.title = newTitle;
    _repository.saveTasks(tasks);
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    _repository.saveTasks(tasks);
    notifyListeners();
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    _repository.saveTasks(tasks);
    notifyListeners();
  }
}
