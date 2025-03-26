import 'package:hive/hive.dart';

part 'taskdatabase.g.dart';

@HiveType(typeId: 0)
class Taskdatabase {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted = false;

  Taskdatabase({required this.title, required this.isCompleted});
}
