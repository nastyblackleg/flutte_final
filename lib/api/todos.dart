import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

Future<Todos> fetchTodos() async {
  final response = await http.get(Uri.parse('http://192.168.1.4:8080/todos'));

  if (response.statusCode == 200) {
    return Todos.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load todos');
  }
}

Future<http.Response> createTodo(Todo todo) {
  return http.post(
    Uri.parse('http://192.168.1.4:8080/add-todo'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'id': todo.id,
      'todo': todo.todo,
      'isDone': todo.isDone,
      'description': todo.description,
    }),
  );
}

Future<http.Response> deleteTodo(id) {
  return http.delete(
    Uri.parse('http://192.168.1.4:8080/delete-todo/' + id.toString()),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

Future<http.Response> updateTodo(Todo todo) {
  return http.put(
    Uri.parse('http://192.168.1.4:8080/update-todo'),
    body: jsonEncode(<String, dynamic>{
      'id': todo.id,
      'todo': todo.todo,
      'isDone': todo.isDone,
      'description': todo.description,
    }),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
}

class Todo {
  final int id;
  final String todo;
  final bool isDone;
  final String description;

  Todo({
    required this.id,
    required this.todo,
    required this.isDone,
    required this.description,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      todo: json['todo'],
      isDone: json['isDone'],
      description: json['description'],
    );
  }
}

class Todos {
  List<Todo> todos;
  Todos({
    required this.todos,
  });
  factory Todos.fromJson(List json) {
    List<Todo> todos = json.map((todo) => Todo.fromJson(todo)).toList();
    return Todos(todos: todos);
  }
}
