import 'package:flutter_test/flutter_test.dart';
import 'package:tarefas/app/home/models/geo_point_model.dart';
import 'package:tarefas/app/home/models/task_model.dart';
import 'package:tarefas/app/home/presenter/controllers/home_controller.dart';

void main() {
  late HomeController controller;

  final task1 = TaskModel(
    title: 'Comprar pão',
    description: 'Comprar pão de leite',
    pointModel: GeoPointModel(latitude: 0, longitude: 0),
  );

  final task2 = TaskModel(
    title: 'Comprar leite',
    description: 'Comprar leite de pão',
    pointModel: GeoPointModel(latitude: 0, longitude: 0),
  );

  setUp(() {
    controller = HomeController();
  });

  group('HomeController', () {
    test('deve adicionar uma task corretamente', () {
      controller.addTask(task1);

      expect(controller.tasks.value.length, 1);
      expect(controller.tasks.value.first.title, equals('Comprar pão'));
    });

    test('deve remover uma task corretamente', () {
      controller.addTask(task1);
      controller.addTask(task2);

      controller.deleteTask(task1);

      expect(controller.tasks.value.length, 1);
      expect(controller.tasks.value.first.title, equals('Comprar leite'));
    });

    test('deve atualizar uma task corretamente', () {
      controller.addTask(task1);

      final updatedTask = TaskModel(
        title: 'Comprar pão integral',
        description: 'Sem glúten',
        pointModel: GeoPointModel(latitude: 1, longitude: 1),
      );

      controller.updateTask(0, updatedTask);

      expect(controller.tasks.value.length, 1);
      expect(controller.tasks.value.first.title, equals('Comprar pão integral'));
      expect(controller.tasks.value.first.pointModel.latitude, equals(1));
    });
  });
}
