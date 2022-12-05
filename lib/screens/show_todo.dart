import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_curd/provider/todo_provider.dart';
import 'package:sqflite_curd/screens/add_todo_screen.dart';

class ShowTodoScreen extends StatelessWidget {
  const ShowTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Provider.of<TodoProvider>(context, listen: false)
          //     .intentScreen(context, const AddTodoScreen());
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const AddTodoScreen();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
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
                          return Card(
                            elevation: 8,
                            child: ListTile(
                              title: Text(todoProvider.todoItem[index].title),
                              subtitle: Text(
                                  todoProvider.todoItem[index].description),
                              trailing: Text(todoProvider.todoItem[index].date),
                            ),
                          );
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
