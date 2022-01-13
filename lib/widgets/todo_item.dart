import 'package:final_todo_app/api/todos.dart';
import 'package:final_todo_app/screens/main.dart';
import 'package:flutter/material.dart';

class TodoItem extends StatefulWidget {
  final int id;
  final String todo;
  final String description;
  final bool isActive;
  final Function refetchTodos;

  const TodoItem(
      {Key? key,
      required this.id,
      required this.isActive,
      required this.todo,
      required this.refetchTodos,
      required this.description})
      : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _detailsFocus = FocusNode();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          widget.todo,
                          softWrap: false,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 25),
                        ),
                        Text(
                          widget.description,
                          softWrap: false,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    updateTodo(Todo(
                                            id: widget.id,
                                            todo: widget.todo,
                                            isDone: !widget.isActive,
                                            description: widget.description))
                                        .then((value) => {
                                              widget.refetchTodos(),
                                              Navigator.pop(context)
                                            });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.done),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Done")
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color.fromRGBO(
                                        66, 149, 145, 1), // <-- Button color
                                  )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    setState(() {
                                      _titleController.text = widget.todo;
                                      _detailsController.text =
                                          widget.description;
                                    });
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Container(
                                            child: Column(
                                              children: [
                                                CustomTextField(
                                                  label: "Please enter title",
                                                  focusNode: _titleFocus,
                                                  controller: _titleController,
                                                  updateState: (text) {
                                                    setState(() {});
                                                  },
                                                ),
                                                CustomTextField(
                                                  label: "Please enter details",
                                                  focusNode: _detailsFocus,
                                                  controller:
                                                      _detailsController,
                                                  updateState: (text) {
                                                    setState(() {});
                                                  },
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        var todo = Todo(
                                                            id: int.parse(widget
                                                                .id
                                                                .toString()),
                                                            todo:
                                                                _titleController
                                                                    .text,
                                                            isDone: false,
                                                            description:
                                                                _detailsController
                                                                    .text);
                                                        updateTodo(todo).then(
                                                            (value) => {
                                                                  widget
                                                                      .refetchTodos(),
                                                                  Navigator.pop(
                                                                      context)
                                                                });
                                                        _titleController
                                                            .clear();
                                                        _detailsController
                                                            .clear();
                                                      });
                                                    },
                                                    child: const Text("Submit"))
                                              ],
                                            ),
                                            padding: const EdgeInsets.fromLTRB(
                                                27, 16, 27, 0),
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  66, 149, 145, 1),
                                            ),
                                          );
                                        });
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Edit")
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color.fromRGBO(
                                        66, 149, 145, 1), // <-- Button color
                                  )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: const Text("Delete Todo"),
                                              content:
                                                  const Text('Are you sure'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                          context, 'Cancel'),
                                                  child: const Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () => {
                                                    deleteTodo(widget.id).then(
                                                        (value) => widget
                                                            .refetchTodos()),
                                                    Navigator.pop(
                                                        context, 'Yes'),
                                                    Navigator.pop(context)
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                              ],
                                            ));
                                  },
                                  child: Column(
                                    children: [
                                      Icon(Icons.delete),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text("Delete")
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color.fromRGBO(
                                        66, 149, 145, 1), // <-- Button color
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(27, 16, 27, 0),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(66, 149, 145, 1),
                  ),
                );
              });
        },
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.todo,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.description,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: widget.isActive
                      ? const Color.fromRGBO(14, 204, 87, 1)
                      : const Color.fromRGBO(150, 152, 151, 1),
                  shape: BoxShape.circle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
