import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_curd/provider/todo_provider.dart';
import 'package:sqflite_curd/screens/add_todo_screen.dart';
import 'package:sqflite_curd/screens/edit_todo.dart';

class ShowTodoScreen extends StatelessWidget {
  const ShowTodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
                          return Dismissible(
                            key: ValueKey(todoProvider.todoItem[index].id),
                            background: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.all(width * 0.01),
                              padding: EdgeInsets.all(width * 0.03),
                              // decoration: BoxDecoration(
                              //   color: Colors.green,
                              //   borderRadius:
                              //       BorderRadius.circular(width * 0.03),
                              // ),
                              color: Colors.green,
                              height: height * 0.02,
                              width: width,
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.endToStart) {
                                return await Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return  EditTodoScreen(
                                    id: todoProvider.todoItem[index].id,
                                    title: todoProvider.todoItem[index].title,
                                    discription: todoProvider.todoItem[index].description,
                                    date: todoProvider.todoItem[index].date,
                                  );
                                }));
                              }
                              // else if(direction == DismissDirection.startToEnd){
                              //   re
                              // }
                            },
                            child: Card(
                              elevation: 8,
                              child: ListTile(
                                title: Text(todoProvider.todoItem[index].title),
                                subtitle: Text(
                                    todoProvider.todoItem[index].description),
                                    
                                trailing:
                                    Text(todoProvider.todoItem[index].date),
                                    
                              ),
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
