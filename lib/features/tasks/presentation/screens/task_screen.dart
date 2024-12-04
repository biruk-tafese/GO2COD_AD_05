import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/features/tasks/data/models/task_model.dart';
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
                      final task = Task(
                        id: DateTime.now().toString(),
                        title: _taskController.text,
                      );

                      // Add task and trigger notification
                      Provider.of<TasksController>(context, listen: false)
                          .addTask(task);
                      _taskController.clear();
                    }
                  },
                ),
              ),
            ),
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
                      onDelete: () {
                        // Delete task and trigger notification
                        Provider.of<TasksController>(context, listen: false)
                            .deleteTask(task);
                      },
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
