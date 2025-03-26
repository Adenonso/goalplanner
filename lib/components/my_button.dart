//contains the button widget and the deadline button widget

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyButton extends StatelessWidget {
  VoidCallback onPressed;
  final String buttonTitle;

  MyButton({
    super.key,
    required this.onPressed,
    required this.buttonTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125,
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          buttonTitle,
          style: TextStyle(fontSize: 17, color: Colors.grey.shade700),
        ),
      ),
    );
  }
}

///DEADLINE BUTTON
class Deadline_Button extends StatefulWidget {
  const Deadline_Button({super.key});

  @override
  State<Deadline_Button> createState() => _Deadline_ButtonState();
}

class _Deadline_ButtonState extends State<Deadline_Button> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 10,
        children: [
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child:
                        Text("Set Deadline", style: TextStyle(fontSize: 17)))),
          ),
          Container(
            width: 120,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: Text(DateFormat('yyyy-MM-dd').format(_selectedDate),
                  style: TextStyle(fontSize: 17, color: Colors.white)),
            ),
          ),
        ],
      ),
    ); // Replace with your widget tree
  }
}
