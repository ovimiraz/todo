import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

showMsg(BuildContext context, String  msg)=>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

String getFormatedDate(DateTime dt) => DateFormat('dd/MM/yyyy').format(dt);

String getFormatedTime(TimeOfDay t) =>
    DateFormat('hh:mm a').format(DateTime(
      0,
      0,
      0,
      t.hour,
      t.minute,
    ));
