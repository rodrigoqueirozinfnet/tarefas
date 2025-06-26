import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tarefas/app/login/presenter/controllers/user_controller.dart';

class FormLoginComponent extends StatefulWidget {
  final bool isRegister;
  const FormLoginComponent({super.key, required this.isRegister});

  @override
  State<FormLoginComponent> createState() => _FormLoginComponentState();
}

class _FormLoginComponentState extends State<FormLoginComponent> {
  final controller = Modular.get<UserController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        TextFormField(
          controller: controller.emailController,
          decoration: const InputDecoration(labelText: 'email'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira um email';
            }
            return null;
          },
        ),
        TextFormField(
          controller: controller.passwordController,
          decoration: const InputDecoration(labelText: 'senha'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira uma senha';
            }
            return null;
          },
        ),
        if (widget.isRegister)
          TextFormField(
            controller: controller.confirmController,
            decoration: const InputDecoration(labelText: 'confirmar senha'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira uma senha';
              } else if (value != controller.passwordController.text) {
                return 'As senhas nao conferem';
              }
              return null;
            },
          ),
      ],
    );
  }
}
