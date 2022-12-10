import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:sqflite_curd/provider/todo_provider.dart';

class EditTodoScreen extends StatefulWidget {
  const EditTodoScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.discription,
    required this.date,
  }) : super(key: key);
  final String id, title, discription, date;

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _date = TextEditingController();

  @override
  void initState() {
    _title.text = widget.title;
    _description.text = widget.discription;
    _date.text = widget.date;
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _title,
              decoration: const InputDecoration(hintText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _description,
              decoration: const InputDecoration(hintText: 'description'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: _date,
              decoration: const InputDecoration(hintText: 'Date'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: ElevatedButton(
              onPressed: () async {
                Provider.of<TodoProvider>(context, listen: false).updateData(
                    _title, _description, _date, widget.id.toString(), context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Update ToDo'),
            ),
          ),
        ],
      ),
    );
  }
}
