import 'package:flutter/material.dart';
import 'package:tarefas/app/home/datasouces/get_weather_datasource.dart';
import 'package:tarefas/app/home/models/geo_point_model.dart';

class GetWeatherController {
  final GetWeatherDatasource datasource;

  GetWeatherController(this.datasource);

  final isLoading = ValueNotifier(false);
  String temperature = '';
  String? erro;

  Future<void> call(GeoPointModel geoPoint) async {
    isLoading.value = true;
    erro = null;
    try {
      final result = await datasource(lat: geoPoint.latitude, long: geoPoint.longitude);
      temperature = result;
    } catch (e) {
      erro = 'Erro ao buscar temperatura: $e';
    }
    isLoading.value = false;
  }
}
