import 'package:flutter/foundation.dart';
import 'package:to_do/models/todo_models.dart';

class TodoProvider with ChangeNotifier{
List<TodoModel> todolist = [];
void addtodo(TodoModel model){
  todolist.add(model);
  notifyListeners();
}

void Changetodostatus(TodoModel todoModel){
 final index = todolist.indexOf(todoModel);
 todolist[index].iscompleded =!todolist[index].iscompleded;
 notifyListeners();
}
}