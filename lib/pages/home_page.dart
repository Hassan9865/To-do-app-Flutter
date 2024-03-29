import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_book/switch.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readTodo();
  }

  var taskBox = Hive.box("taskBox");
  List<Map<String, dynamic>> todos = [];
  TextEditingController todoController = TextEditingController();

  // void addTodo() {
  //   String newTodo = todoController.text;
  //   if (newTodo.isNotEmpty) {
  //     setState(() {
  //       todos.add(newTodo);
  //     });
  //     todoController.clear();
  //   }
  // }

  addTodo(Map<String, dynamic> data) async {
    await taskBox.add(data);
    readTodo();
  }

  readTodo() async {
    var data = taskBox.keys.map((key) {
      final item = taskBox.get(key);
      return {'key': key, 'task': item['task']};
    }).toList();

    setState(() {
      todos = data.reversed.toList();
    });
  }

  // void updateTodo(int index) {
  //   String updatedTodo = todoController.text;
  //   if (updatedTodo.isNotEmpty) {
  //     setState(() {
  //       todos[index] = updatedTodo;
  //     });
  //     todoController.clear();
  //   }
  // }

  updateTodo(int? key, Map<String, dynamic> data) async {
    await taskBox.put(key, data);
    readTodo();
  }

  // void deleteTodo(int index) {
  //   setState(() {
  //     todos.removeAt(index);
  //   });
  // }

  deleteTodo(int? key) async {
    await taskBox.delete(key);
    readTodo();
  }

  showModel(context, int? key) async {
    todoController.clear();

    if (key != null) {
      final item = todos.firstWhere((element) => element['key'] == key);
      todoController.text = item['task'];
    }
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(key == null ? "Add To-Do" : "Edit Todo"),
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
                var data = {
                  "task": todoController.text,
                };
                if (key == null) {
                  addTodo(data);
                } else {
                  updateTodo(key, data);
                }

                Navigator.pop(context);
              },
              child: Text(key == null ? "Add" : "Update"),
            ),
          ],
        );
      },
    );
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
          var currentitem = todos[index];
          return ListTile(
            title: Text(
              currentitem['task'],
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
                    // todoController.text = todos[index];
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return AlertDialog(
                    //       title: Text("Edit To-Do"),
                    //       content: TextField(
                    //         controller: todoController,
                    //       ),
                    //       actions: [
                    //         TextButton(
                    //           onPressed: () {
                    //             Navigator.pop(context);
                    //           },
                    //           child: Text("Cancel"),
                    //         ),
                    //         TextButton(
                    //           onPressed: () {
                    //             // updateTodo(index);
                    //             Navigator.pop(context);
                    //           },
                    //           child: Text("Save"),
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // );
                    showModel(context, currentitem['key']);
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
                                // deleteTodo(index);
                                deleteTodo(currentitem['key']);
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
          showModel(context, null);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
