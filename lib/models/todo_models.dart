import 'package:flutter/material.dart';

class TodoModel {
  int id;
  String name;
  String priority;
  DateTime dateTime;
  TimeOfDay timeOfDay;
  bool iscompleded;

  TodoModel(
  {
   required this.id,
    required this.name,
    required  this.priority,
    required this.dateTime,
    required this.timeOfDay,
    this.iscompleded = false,
}
  );


}
