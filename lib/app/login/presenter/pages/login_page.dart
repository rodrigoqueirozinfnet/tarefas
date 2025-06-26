import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefas/app/login/presenter/controllers/user_controller.dart';
import 'package:tarefas/app/login/presenter/pages/components/form_login_component.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final userController = Modular.get<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: DsText('Login', style: DsTextStyle.bigTitle)),
      body: ValueListenableBuilder(
        valueListenable: userController.isLoading,
        builder: (context, isLoading, child) {
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
                key: _formKey,
                child: Column(
                  spacing: 16,
                  children: [
                    FormLoginComponent(isRegister: false),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          userController.login();
                        }
                      },
                      child: const DsText('Entrar'),
                    ),

                    TextButton(
                      onPressed: () => Modular.to.pushNamed('/create-login/'),
                      child: DsText('Não tem login? Crie sua conta'),
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
