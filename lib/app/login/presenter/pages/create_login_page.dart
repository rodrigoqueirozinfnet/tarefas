import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefas/app/login/presenter/controllers/user_controller.dart';
import 'package:tarefas/app/login/presenter/pages/components/form_login_component.dart';

class CreateLoginPage extends StatefulWidget {
  const CreateLoginPage({super.key});

  @override
  State<CreateLoginPage> createState() => _CreateLoginPageState();
}

class _CreateLoginPageState extends State<CreateLoginPage> {
  final formKey = GlobalKey<FormState>();
  final userController = Modular.get<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: DsText('Criar Conta', style: DsTextStyle.bigTitle)),
      body: ValueListenableBuilder(
        valueListenable: userController.isLoading,
        builder: (_, isLoading, child) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (userController.erro != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: DsText(userController.erro!)));
            });
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                key: formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    FormLoginComponent(isRegister: true),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          userController.createUser();
                        }
                      },
                      child: const DsText('Criar'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
