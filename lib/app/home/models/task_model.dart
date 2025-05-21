import 'package:tarefas/app/home/models/geo_point_model.dart';

class TaskModel {
  final String title;
  final String? description;
  final GeoPointModel pointModel;

  TaskModel({required this.title, this.description, required this.pointModel});
}
