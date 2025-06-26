import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefas/app_module.dart';
import 'package:tarefas/app_widget.dart';
import 'package:tarefas/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
