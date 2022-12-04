import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_curd/provider/todo_provider.dart';

class ShowTodoScreen extends StatelessWidget {
  const ShowTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: FutureBuilder(
        future: Provider.of<TodoProvider>(context, listen: false).selectData(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Consumer<TodoProvider>(
              builder: ((context, todoProvider, child) {
                return todoProvider.todoItem.isNotEmpty
                    ? ListView.builder(
                        itemCount: todoProvider.todoItem.length,
                        itemBuilder: (context, index) {
                          return const ListTile();
                        },
                      )
                    : const Center(
                        child: Text(
                          'Empty',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 28,
                          ),
                        ),
                      );
              }),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
                color: Colors.black,
                strokeWidth: 2,
              ),
            );
          }
        }),
      ),
    );
  }
}
