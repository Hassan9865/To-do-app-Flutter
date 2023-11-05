import 'package:flutter/material.dart';
import 'package:note_book/switch.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> todos = [];
  TextEditingController todoController = TextEditingController();

  void addTodo() {
    String newTodo = todoController.text;
    if (newTodo.isNotEmpty) {
      setState(() {
        todos.add(newTodo);
      });
      todoController.clear();
    }
  }

  void updateTodo(int index) {
    String updatedTodo = todoController.text;
    if (updatedTodo.isNotEmpty) {
      setState(() {
        todos[index] = updatedTodo;
      });
      todoController.clear();
    }
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text("To-Do List"),
        actions: [
          ApnaSwitch(),
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              todos[index],
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    todoController.text = todos[index];
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Edit To-Do"),
                          content: TextField(
                            controller: todoController,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                updateTodo(index);
                                Navigator.pop(context);
                              },
                              child: Text("Save"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Delete To-Do"),
                          content: Text(
                              "Are you sure you want to delete this item?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteTodo(index);
                                Navigator.pop(context);
                              },
                              child: Text("Delete"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add To-Do"),
                content: TextField(
                  controller: todoController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      addTodo();
                      Navigator.pop(context);
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
