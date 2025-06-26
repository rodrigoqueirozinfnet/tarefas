import 'package:design_system/componentes/text/ds_text.dart';
import 'package:design_system/componentes/text/ds_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefas/app/home/models/task_model.dart';
import 'package:tarefas/app/home/presenter/controllers/home_controller.dart';
import 'package:tarefas/app/home/presenter/pages/components/weather_component.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Modular.get<HomeController>();

  late MediaQueryData mediaQuery;
  late bool isLandescape;

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    isLandescape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const DsText('Lista de Tarefas', style: DsTextStyle.bigTitle),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(bottom: mediaQuery.padding.bottom),
        child: ValueListenableBuilder<List<TaskModel>>(
          valueListenable: homeController.tasks,
          builder: (context, tasks, child) {
            if (isLandescape) {
              return SingleChildScrollView(
                child: Wrap(
                  children:
                      tasks
                          .map(
                            (e) => Card(
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                height: mediaQuery.size.height / 3,
                                width: mediaQuery.size.width / 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      spacing: 4,
                                      children: [
                                        const Icon(Icons.task),
                                        Expanded(
                                          child: DsText(
                                            e.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          DsText(
                                            e.description ?? '',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),

                                          WeatherComponent(geoPoint: e.pointModel),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () {
                                            Modular.to.pushNamed('/form-task/', arguments: e);
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed: () {
                                            homeController.deleteTask(e);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              );
            }
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  leading: const Icon(Icons.task),
                  title: DsText(task.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DsText(task.description ?? ''),
                      WeatherComponent(geoPoint: task.pointModel),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          Modular.to.pushNamed('/form-task/', arguments: task);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          homeController.deleteTask(task);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Modular.to.pushNamed('/form-task/'),
      ),
    );
  }
}
