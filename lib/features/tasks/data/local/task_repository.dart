import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task_model.dart';

class TaskRepository {
  static const String _taskKey = 'tasks';

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_taskKey) ?? [];
    return tasksJson.map((e) => Task.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = tasks.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_taskKey, tasksJson);
  }
}
