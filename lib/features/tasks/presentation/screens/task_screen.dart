import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/features/tasks/data/models/task_model.dart';
import 'package:todoapp/core/utils/notification_helper.dart';
import '../../controllers/tasks_controller.dart';
import '../widgets/task_item.dart';

class TasksScreen extends StatelessWidget {
  final TextEditingController _taskController = TextEditingController();

  TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TODO App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: 'Enter a new task',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      Provider.of<TasksController>(context, listen: false)
                          .addTask(Task(
                        id: DateTime.now().toString(),
                        title: _taskController.text,
                      ));
                      _taskController.clear();
                    }
                  },
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await NotificationHelper.scheduleNotification(
                id: 0,
                title: 'Test Notification',
                body: 'This is a test notification',
                scheduledTime: DateTime.now().add(const Duration(seconds: 5)),
              );
            },
            child: const Text('Send Test Notification'),
          ),
          Expanded(
            child: Consumer<TasksController>(
              builder: (_, controller, __) {
                return ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (_, index) {
                    final task = controller.tasks[index];
                    return TaskItem(
                      task: task,
                      onToggle: () =>
                          Provider.of<TasksController>(context, listen: false)
                              .toggleTaskCompletion(task),
                      onDelete: () =>
                          Provider.of<TasksController>(context, listen: false)
                              .deleteTask(task),
                      onEdit: (newTitle) =>
                          Provider.of<TasksController>(context, listen: false)
                              .editTask(task, newTitle),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
