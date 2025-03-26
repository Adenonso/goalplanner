import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:star_todo/data/goaldatabase.dart';

class Database {
  List tasks = [];
  // List goalslist = [];

  //reference to the box
  final Box<GoalsDatabase> _goalsBox = Hive.box<GoalsDatabase>('goalsBox');

  List<GoalsDatabase> getGoals() {
    return _goalsBox.values.toList();
  }

  //run this method if this is the first time opening the app
  // void createInitialData() {
  //   tasks = [];
  //   allGoals = [];
  // }

  //add goals
  void addGoal(GoalsDatabase goals) {
    _goalsBox.add(goals);
  }

  //load the data from database
  // void loadData() {
  //   tasks = _goalsBox.get('T', defaultValue: []);
  //   allGoals = _myBox.get('ALL_GOALS');
  // }

  //update the database
  void updateGoalDataBase(int index, GoalsDatabase goals) {
    _goalsBox.put(index, goals);
  }

  void deleteGoal(int index) {
    _goalsBox.deleteAt(index);
  }
}
