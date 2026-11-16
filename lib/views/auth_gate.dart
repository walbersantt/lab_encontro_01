import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';
import 'login_page.dart';
import 'visitas_page.dart'; // Import correto para a tela de visitas

class AuthGate extends StatelessWidget {
  AuthGate({super.key});

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        // Enquanto verifica o estado de login, mostra um carregamento
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Se o usuário estiver logado, abre a tela de Visitas (CRUD)
        if (snapshot.hasData) {
          return const VisitasPage();
        } else {
          // Se não estiver logado, mostra a tela de Login
          return const LoginPage();
        }
      },
    );
  }
}
