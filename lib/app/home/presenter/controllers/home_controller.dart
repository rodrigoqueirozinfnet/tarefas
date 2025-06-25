import 'package:flutter/foundation.dart';
import 'package:tarefas/app/home/models/geo_point_model.dart';
import 'package:tarefas/app/home/models/task_model.dart';

class HomeController {
  final tasks = ValueNotifier<List<TaskModel>>([]);

  void deleteTask(TaskModel task) {
    tasks.value.remove(task);
    tasks.notifyListeners();
  }

  void addTask(TaskModel task) {
    tasks.value.add(task);
    tasks.notifyListeners();
  }

  void updateTask(int index, TaskModel task) {
    tasks.value[index] = task;
    tasks.notifyListeners();
  }

  Future<void> getTemperature(GeoPointModel geoPoint) async {
    
  }
}
