import 'package:final_todo_app/api/todos.dart';
import 'package:final_todo_app/widgets/todo_item.dart';
import 'package:flutter/material.dart';

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  String _idValue = "";
  String _titleValue = "";
  String _taskValue = "";
  String _detailsValue = "";
  final FocusNode _idFocus = FocusNode();
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _taskFocus = FocusNode();
  final FocusNode _detailsFocus = FocusNode();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  late Future<Todos> futureTodos;

  @override
  void initState() {
    super.initState();
    futureTodos = fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(top: 120),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(23, 0, 48, 91),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "TODO APP",
                  style: TextStyle(fontSize: 32),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    primary: const Color.fromRGBO(
                        4, 163, 163, 1), // <-- Button color
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: Column(
                              children: [
                                CustomTextField(
                                  label: "Please enter ID",
                                  focusNode: _idFocus,
                                  controller: _idController,
                                  updateState: (text) {
                                    setState(() {
                                      _idValue = text;
                                    });
                                  },
                                ),
                                CustomTextField(
                                  label: "Please enter title",
                                  focusNode: _titleFocus,
                                  controller: _titleController,
                                  updateState: (text) {
                                    setState(() {
                                      _titleValue = text;
                                    });
                                  },
                                ),
                                CustomTextField(
                                  label: "Please enter task",
                                  focusNode: _taskFocus,
                                  controller: _taskController,
                                  updateState: (text) {
                                    setState(() {
                                      _taskValue = text;
                                    });
                                  },
                                ),
                                CustomTextField(
                                  label: "Please enter details",
                                  focusNode: _detailsFocus,
                                  controller: _detailsController,
                                  updateState: (text) {
                                    setState(() {
                                      _detailsValue = text;
                                    });
                                  },
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        var todo = Todo(
                                            id: int.parse(_idValue),
                                            todo: _taskValue,
                                            isDone: false,
                                            description: _detailsValue);
                                        createTodo(todo);
                                        _idController.clear();
                                        _titleController.clear();
                                        _taskController.clear();
                                        _detailsController.clear();
                                      });
                                    },
                                    child: const Text("Submit"))
                              ],
                            ),
                            padding: const EdgeInsets.fromLTRB(27, 16, 27, 0),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(66, 149, 145, 1),
                            ),
                          );
                        });
                  },
                  child: const Icon(
                    Icons.add,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Color.fromRGBO(4, 163, 163, 1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            padding: const EdgeInsets.all(48),
            width: double.infinity,
            child: FutureBuilder<Todos>(
                future: futureTodos,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    Todos todos = snapshot.data;

                    return ListView.builder(
                        itemCount: todos.todos.length,
                        itemBuilder: (BuildContext context, int index) {
                          Todo todo = todos.todos[index];
                          return Column(
                            children: [
                              TodoItem(
                                isActive: todo.isDone,
                                todo: todo.todo,
                                description: todo.description,
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                }),
          ))
        ],
      ),
    ));
  }
}

class CustomTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function updateState;
  final String label;

  const CustomTextField(
      {Key? key,
      required this.focusNode,
      required this.label,
      required this.controller,
      required this.updateState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (text) {
            updateState(text);
          },
          focusNode: focusNode,
          controller: controller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              hintText: label,
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              border: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              )),
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
