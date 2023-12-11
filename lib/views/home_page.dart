import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:http/http.dart';
import 'package:mp5/models/task.dart';
import 'package:mp5/views/add_tasks_page.dart';
import 'package:mp5/views/completed_tasks_page.dart';
import 'package:mp5/service/quote_service.dart';
import 'package:mp5/models/quote.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:mp5/models/quote.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as Dio;


class QuoteService {
  Future<Map<String, dynamic>> fetchQuote() async {
    try {
      final response = await http.get(Uri.parse('https://api.quotable.io/random'));
      return json.decode(response.body);
    } catch (e) {
      print('Error fetching quote: $e');
      throw e;
    }
  }

  Future<Quote> fetchParsedQuote() async {
    try {
      final Map<String, dynamic> responseData = await fetchQuote();

      if (responseData.containsKey('content') && responseData.containsKey('author')) {
        return Quote.fromJson(responseData);
      } else {
        throw Exception('Failed to parse quote data');
      }
    } catch (e) {
      print('Error loading quote: $e');
      return Quote(
        id: '',
        tags: '',
        content: '',
        author: '',
        authorSlug: '',
        length: null,
        dateAdded: '',
        dateModified: '',
      );
    }
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  List<Task> completedTasks = [];
  final QuoteService _quoteService = QuoteService();
  Quote _quote = Quote(
    id: '',
    tags: '',
    content: '',
    author: '',
    authorSlug: '',
    length: 0,
    dateAdded: '',
    dateModified: '',
  );

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadQuote();
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Load tasks from SharedPreferences
    String? taskString = prefs.getString('tasks');
    if (taskString != null) {
      setState(() {
        tasks = (jsonDecode(taskString) as List<dynamic>)
            .map((taskJson) => Task.fromJson(taskJson))
            .toList();
      });
    }
    String? completedTasksString = prefs.getString('completedTasks');
    if (completedTasksString != null) {
      setState(() {
        completedTasks = (jsonDecode(completedTasksString) as List<dynamic>)
            .map((taskJson) => Task.fromJson(taskJson))
            .toList();
      });
    }
  }

  void _loadQuote() async {
  try {
    print('Fetching quote...');
    final Map<String, dynamic> responseData = await _quoteService.fetchQuote();

    // You can check for the required fields in responseData and handle errors accordingly
    if (responseData.containsKey('content') && responseData.containsKey('author')) {
      final Quote quote = Quote.fromJson(responseData);
      setState(() {
        _quote = quote;
      });
    } else {
      print('Failed to load quote. Response data does not contain required fields.');
      // You can provide a default quote or display an error message
    }
  } catch (e) {
    print('Error loading quote: $e');
    // Handle the error, e.g., show a message to the user
    // You can provide a default quote or display an error message
  }
}



  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save tasks to SharedPreferences
    String taskString =
        jsonEncode(tasks.map((task) => task.toJson()).toList());
    prefs.setString('tasks', taskString);
  }

  void _saveCompletedTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save completed tasks to SharedPreferences
    String completedTasksString =
        jsonEncode(completedTasks.map((task) => task.toJson()).toList());
    prefs.setString('completedTasks', completedTasksString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('To-Do List App')),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.done),
            onPressed: () {
              // Navigate to the Completed Tasks Page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompletedTasksPage(
                    completedTasks: completedTasks,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today\'s Tasks',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildTaskList(),
            SizedBox(height: 16),
            Text(
              'Quote of the Day:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${_quote.content} - ${_quote.author}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Add Task Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(onTaskAdded: _addTask),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: tasks.map((task) => _buildTaskItem(task)).toList(),
    );
  }

  Widget _buildTaskItem(Task task) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: task.isCompleted,
                    onChanged: (bool? value) {
                      _markTaskAsCompleted(task);
                    },
                  ),
                  SizedBox(width: 8),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                task.details ?? 'No details available',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          // Delete icon on the extreme right
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteTask(task);
            },
          ),
        ],
      ),
    );
  }

  // Callback to add a new task to the list
  void _addTask(Task newTask) {
    setState(() {
      tasks.add(newTask);
      _saveTasks(); // Save tasks when adding a new task
    });
  }

  void _markTaskAsCompleted(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
      if (task.isCompleted) {
        completedTasks.add(task);
        tasks.remove(task);
      } else {
        completedTasks.remove(task);
        tasks.add(task);
      }
      _saveTasks();
      _saveCompletedTasks(); // Save tasks when marking a task as completed
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      tasks.remove(task);
      completedTasks.remove(task);
      _saveTasks();
      _saveCompletedTasks(); // Save tasks when deleting a task
    });
  }
}
