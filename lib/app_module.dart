import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefas/app/home/datasouces/get_weather_datasource.dart';
import 'package:tarefas/app/home/presenter/controllers/get_temperature_controller.dart';
import 'package:tarefas/app/home/presenter/controllers/home_controller.dart';
import 'package:tarefas/app/home/presenter/pages/form_task_page.dart';
import 'package:tarefas/app/home/presenter/pages/home_page.dart';
import 'package:tarefas/app/login/presenter/controllers/user_controller.dart';
import 'package:tarefas/app/login/presenter/pages/create_login_page.dart';
import 'package:tarefas/app/login/presenter/pages/login_page.dart';
import 'package:tarefas/services/http_service.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(HttpService.new);
    i.addLazySingleton(HomeController.new);

    i.add(GetWeatherController.new);
    i.add(GetWeatherDatasource.new);

    i.addLazySingleton(UserController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => LoginPage());
    r.child('/create-login/', child: (context) => CreateLoginPage());
    r.child('/home/', child: (context) => HomePage());
    r.child('/form-task/', child: (context) => FormTaskPage(task: r.args.data));
  }
}
