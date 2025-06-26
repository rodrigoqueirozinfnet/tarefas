import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefas/app/home/models/geo_point_model.dart';
import 'package:tarefas/app/home/presenter/controllers/get_temperature_controller.dart';

class WeatherComponent extends StatefulWidget {
  final GeoPointModel geoPoint;
  const WeatherComponent({super.key, required this.geoPoint});

  @override
  State<WeatherComponent> createState() => _WeatherComponentState();
}

class _WeatherComponentState extends State<WeatherComponent> {
  final controller = Modular.get<GetWeatherController>();

  @override
  void initState() {
    super.initState();
    controller(widget.geoPoint);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.isLoading,
      builder: (context, loading, child) {
        if (loading) {
          return Center(child: CircularProgressIndicator());
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.thermostat),
            DsText(
              controller.erro != null
                  ? '${controller.erro}'
                  : 'Temperatura: ${controller.temperature} °C',
              style: DsTextStyle.subText,
            ),
          ],
        );
      },
    );
  }
}
