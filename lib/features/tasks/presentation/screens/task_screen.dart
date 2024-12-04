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
      appBar: AppBar(
        title: const Text('TODO App',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'My Tasks',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      color: Colors.deepPurpleAccent,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: 'Enter a new task',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 20),
                    hintStyle: const TextStyle(color: Colors.black54),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add_circle_outline,
                          color: Colors.deepPurpleAccent),
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Consumer<TasksController>(
                builder: (_, controller, __) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.tasks.length,
                    itemBuilder: (_, index) {
                      final task = controller.tasks[index];
                      return Card(
                        elevation: 8,
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TaskItem(
                          task: task,
                          onToggle: () => Provider.of<TasksController>(context,
                                  listen: false)
                              .toggleTaskCompletion(task),
                          onDelete: () {
                            // Delete task and trigger notification
                            Provider.of<TasksController>(context, listen: false)
                                .deleteTask(task);
                          },
                          onEdit: (newTitle) => Provider.of<TasksController>(
                                  context,
                                  listen: false)
                              .editTask(task, newTitle),
                        ),
                      );
                    },
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
