import 'package:flutter/material.dart';
import 'package:mp5/models/task.dart';

class CompletedTasksPage extends StatefulWidget {
  final List<Task> completedTasks;

  CompletedTasksPage({Key? key, required this.completedTasks}) : super(key: key);

  @override
  _CompletedTasksPageState createState() => _CompletedTasksPageState();
}

class _CompletedTasksPageState extends State<CompletedTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Completed Tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildCompletedTasksList(),
      ),
    );
  }

  Widget _buildCompletedTasksList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Finished Tasks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        _buildCompletedTasksItems(),
      ],
    );
  }

  Widget _buildCompletedTasksItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.completedTasks
          .map((task) => _buildCompletedTaskItem(task))
          .toList(),
    );
  }

  Widget _buildCompletedTaskItem(Task completedTask) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.check, color: Colors.green), // Icon to indicate completion
          SizedBox(width: 8),
          Text(completedTask.title),
        ],
      ),
    );
  }
}
