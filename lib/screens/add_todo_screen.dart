import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_curd/provider/todo_provider.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _date = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to do'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: _title,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: _description,
              decoration: const InputDecoration(hintText: 'description'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: _date,
              decoration: const InputDecoration(hintText: 'Date'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: ElevatedButton(
              onPressed: () async {
                await todoProvider.insertData(
                  _title.text,
                  _description.text,
                  _date.text,
                );
                _title.clear();
                _description.clear();
                _date.clear();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Add ToDo'),
            ),
          ),
        ],
      ),
    );
  }
}
