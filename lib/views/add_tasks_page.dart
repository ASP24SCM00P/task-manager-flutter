import 'package:flutter/material.dart';
import 'package:mp5/models/task.dart';

class AddTaskPage extends StatelessWidget {
  final Function(Task) onTaskAdded;

  const AddTaskPage({Key? key, required this.onTaskAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Task Name:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(hintText: 'Task Name'),
              onSubmitted: (String taskName) {
                // Notify the callback in the parent widget
                // Create a new Task object
           //   Task newTask = Task(title: taskName, details: '', isCompleted: false, id: UniqueKey().toString());
              Task newTask = Task(
              id: UniqueKey().toString(),
              title: taskName,
              details: '',
              isCompleted: false,
              );

                onTaskAdded(newTask);
                // Navigate back to the Home Page
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}