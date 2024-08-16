import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/todo_models.dart';
import 'package:to_do/pages/new_todo.dart';
import 'package:to_do/providers/To_Providers.dart';
import 'package:to_do/utiils/helper_fuctions.dart';

class TodoHome extends StatelessWidget {
  static const String routeName = '/';

  const TodoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewTodo.routeName),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('Todo List'), centerTitle: true,),
      body: Consumer<TodoProvider>(
        builder: (context, provider, child) =>
            ListView.builder(
              itemCount: provider.todolist.length,
              itemBuilder: (context, index) {
                final todo = provider.todolist[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(todo.name),
                    subtitle: Text(todo.iscompleded? ' Completed ' :'${getFormatedDate(todo.dateTime)}.${getFormatedTime(todo.timeOfDay)}'),
                    leading: Icon(Icons.star, size: 30, color: getprioritycolor(todo.priority)),
                    trailing: Checkbox(
                      value: todo.iscompleded,
                      onChanged: todo.iscompleded? null :(value){
                        provider.Changetodostatus(todo);

                      },
                    ),
                  ),
                );
              },
            ),
      ),
    );
  }

  Color getprioritycolor(String priority){
    if(priority == 'Low'){
      return Colors.yellow;
    }else if(priority == 'Normal'){
      return Colors.green;
    }else{
      return Colors.red;
    }
  }
}
