import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserController {
  final isLoading = ValueNotifier(false);
  String email = '';
  String? erro;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  Future<void> createUser() async {
    isLoading.value = true;
    erro = null;
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      email = credential.user!.email ?? '';
      Modular.to.pushNamed('/home/');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        erro = 'A senha é muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        erro = 'A conta já existe para esse email.';
      } else {
        erro = e.code;
      }
    } catch (e) {
      erro = e.toString();
    }
    isLoading.value = false;
  }

  Future<void> login() async {
    isLoading.value = true;
    erro = null;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      email = credential.user!.email ?? '';
      Modular.to.pushNamed('/home/');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        erro = 'Não existe um usuário com esse email.';
      } else if (e.code == 'wrong-password') {
        erro = 'Senha incorreta para esse usuário.';
      } else {
        erro = e.code;
      }
    }
    isLoading.value = false;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
