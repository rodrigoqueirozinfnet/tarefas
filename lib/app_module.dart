import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefas/app/home/presenter/controllers/home_controller.dart';
import 'package:tarefas/app/home/presenter/pages/form_task_page.dart';
import 'package:tarefas/app/home/presenter/pages/home_page.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(HomeController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
    r.child('/form-task/', child: (context) => FormTaskPage(task: r.args.data));
  }
}
