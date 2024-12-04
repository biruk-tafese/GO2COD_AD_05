import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todoapp/features/tasks/data/models/task_model.dart';
import 'package:todoapp/services/notification_service.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class TasksController with ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
    NotificationService.showNotification(
      title: 'Task Added',
      body: 'Task "${task.title}" has been added!',
    );
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
    NotificationService.showNotification(
      title: 'Task Deleted',
      body: 'Task "${task.title}" has been deleted!',
    );
  }

  void editTask(Task task, String newTitle) {
    task.title = newTitle;
    notifyListeners();
    NotificationService.showNotification(
      title: 'Task Edited',
      body: 'Task updated to "$newTitle".',
    );
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
    NotificationService.showNotification(
      title: 'Task ${task.isCompleted ? "Completed" : "Incomplete"}',
      body:
          'Task "${task.title}" marked as ${task.isCompleted ? "done" : "pending"}.',
    );
  }

  // Method to show a task deadline reminder
  void remindTaskDeadline(Task task) {
    _showNotification('Task Deadline Reminder',
        'The task "${task.title}" is approaching its deadline.');
  }

  // General notification method
  void _showNotification(String title, String message) async {
    const androidDetails = AndroidNotificationDetails(
      'task_channel_id',
      'Tasks',
      channelDescription: 'Notifications for task actions',
      importance: Importance.max,
      priority: Priority.high,
    );

    const platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      message,
      platformDetails,
    );
  }
}
