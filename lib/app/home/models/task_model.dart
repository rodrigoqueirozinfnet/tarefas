import 'package:tarefas/app/home/models/geo_point_model.dart';

class TaskModel {
  final String title;
  final String? description;
  final GeoPointModel pointModel;

  TaskModel({required this.title, this.description, required this.pointModel});
}

final tasksMock = [
  TaskModel(
    title: 'Comprar pão',
    description: 'Comprar pão de leite',
    pointModel: GeoPointModel(latitude: 0, longitude: 0),
  ),
  TaskModel(
    title: 'Comprar leite',
    description: 'Comprar leite de pão',
    pointModel: GeoPointModel(latitude: 0, longitude: 0),
  ),
];
