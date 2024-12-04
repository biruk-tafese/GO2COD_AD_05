import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
import '../../data/models/task_model.dart';
import '../../../../core/utils/notification_helper.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final Function(String) onEdit;

  const TaskItem({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  void _setReminder(BuildContext context) async {
    final pickedTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedTime != null) {
      NotificationHelper.scheduleNotification(
        id: task.hashCode,
        title: 'Reminder for Task',
        body: task.title,
        scheduledTime: pickedTime,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          )),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) => onToggle(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => _setReminder(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
      onTap: () {
        TextEditingController controller =
            TextEditingController(text: task.title);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Edit Task'),
            content: TextField(controller: controller),
            actions: [
              TextButton(
                onPressed: () {
                  onEdit(controller.text);
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
