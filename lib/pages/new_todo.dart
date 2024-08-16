import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do/models/todo_models.dart';
import 'package:to_do/providers/To_Providers.dart';
import 'package:to_do/utiils/helper_fuctions.dart';

class NewTodo extends StatefulWidget {
  static const String routeName = '/new';

  const NewTodo({super.key});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _todoController = TextEditingController();
  final _priorityList = const ['Low', 'Normal', 'High'];
  String? priority;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Todo '),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            controller: _todoController,
            decoration: InputDecoration(labelText: 'What to do ?'),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<String>(
                  value: priority,
                  underline: null,
                  isExpanded: true,
                  hint: const Text('Select priority'),
                  items: _priorityList
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      priority = value;
                    });
                  }),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: CustomButton(
                onpressed: _seletDate,
                title:
                selectedDate == null ? 'Select Date' : getFormatedDate(selectedDate!)),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: CustomButton(
                onpressed: _seletTime,
                title:
                selectedTime == null ? 'Select Time' : getFormatedTime(selectedTime!)),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: OutlinedButton(
              onPressed: _SaveTodo,
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  void _seletDate() async {
    final Date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (Date != null) {
      setState(() {
        selectedDate = Date;
      });
    }
  }


  void _seletTime() async {
    final Time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (Time != null) {
      setState(() {
        selectedTime = Time;
      });
    }
  }

  void _SaveTodo() {
    if (priority == null) {
      showMsg(context, 'priority  not found');
      return;
    }
    if (selectedDate == null) {
      showMsg(context, 'date not found');
      return;
    }
    if (selectedTime == null) {
      showMsg(context, 'time not found');
      return;
    }
    final todo = TodoModel(
        id: DateTime.now().millisecondsSinceEpoch,
        name: _todoController.text,
        priority: priority!,
        dateTime: selectedDate!,
        timeOfDay: selectedTime!
    );

    Provider.of<TodoProvider>(context,listen: false).addtodo(todo);
    Navigator.pop(context);
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onpressed;

  const CustomButton({super.key, required this.title, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 150,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
              foregroundColor: Colors.black),
          onPressed: onpressed,
          child: Text(title)),
    );
  }
}
