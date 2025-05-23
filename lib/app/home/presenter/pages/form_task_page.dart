import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tarefas/app/home/models/geo_point_model.dart';
import 'package:tarefas/app/home/models/task_model.dart';
import 'package:tarefas/app/home/presenter/controllers/home_controller.dart';
import 'package:tarefas/services/geolocator_service.dart';

class FormTaskPage extends StatefulWidget {
  final TaskModel? task;
  const FormTaskPage({super.key, this.task});

  @override
  State<FormTaskPage> createState() => _FormTaskPageState();
}

class _FormTaskPageState extends State<FormTaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final geolocatorController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final homeController = Modular.get<HomeController>();
  GeoPointModel? pointModel;
  String? _selectedLocation;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description ?? '';
      pointModel = widget.task!.pointModel;
    }
    _getCurrentPosition();
  }

  void _getCurrentPosition() async {
    if (pointModel == null) {
      Position position = await GeolocatorService.determinePosition();
      pointModel = GeoPointModel(latitude: position.latitude, longitude: position.longitude);
    }
    final placeMarks = await placemarkFromCoordinates(
      pointModel?.latitude ?? 0,
      pointModel?.longitude ?? 0,
    );
    _selectedLocation =
        placeMarks.isNotEmpty
            ? '${placeMarks[0].street ?? ''} - ${placeMarks[0].locality ?? ''}'
            : null;

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.task != null ? 'Editar' : 'Criar'} Tarefa')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Título'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um título';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                ),

                SizedBox(height: 36),
                TextFormField(
                  controller: geolocatorController,
                  decoration: InputDecoration(
                    labelText: 'Pesquisar Localização',
                    suffixIcon: IconButton(
                      onPressed: () => searchLocations(),
                      icon: Icon(Icons.search),
                    ),
                  ),
                  onChanged: (value) {},
                ),
                SizedBox(height: 36),
                Row(children: [Text('Localização selecionada:')]),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text('Localização: ${_selectedLocation ?? 'Desconhecido'}'),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 36),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final task = TaskModel(
                        title: titleController.text,
                        description:
                            descriptionController.text.isEmpty ? null : descriptionController.text,
                        pointModel: pointModel ?? GeoPointModel(latitude: 0, longitude: 0),
                      );
                      if (widget.task != null) {
                        final index = homeController.tasks.value.indexOf(widget.task!);
                        homeController.updateTask(index, task);
                      } else {
                        homeController.addTask(task);
                      }
                      Modular.to.pop();
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> searchLocations() async {
    List<Location> locations = await locationFromAddress(geolocatorController.text);
    final marks = await placemarkFromCoordinates(locations[0].latitude, locations[0].longitude);
    if (marks.isNotEmpty) {
      pointModel = GeoPointModel(
        latitude: locations[0].latitude,
        longitude: locations[0].longitude,
      );
      _selectedLocation = '${marks[0].street ?? ''} - ${marks[0].locality ?? ''}';
    }
    setState(() {});
  }
}
