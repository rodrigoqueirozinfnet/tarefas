import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefas/app_module.dart';
import 'package:tarefas/app_widget.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
