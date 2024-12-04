import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/utils/notification_helper.dart';
import 'package:todoapp/features/tasks/presentation/screens/task_screen.dart';
import 'features/tasks/controllers/tasks_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationHelper.initialize(); // Initialize notifications
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TasksController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    );
  }
}
