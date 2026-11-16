import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:io' show Platform;

// Importe o seu AuthGate (ajuste o caminho se necessário conforme suas pastas)
import 'views/auth_gate.dart';

void main() async {
  // 1. Garante que os bindings do Flutter estejam inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inicializa o Firebase lendo as opções do config/firebase_projeto.json
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: String.fromEnvironment(
        'FIREBASE_API_KEY',
        defaultValue: 'demo-api-key',
      ),
      appId: String.fromEnvironment(
        'FIREBASE_APP_ID',
        defaultValue: 'demo-app-id',
      ),
      messagingSenderId: String.fromEnvironment(
        'FIREBASE_SENDER_ID',
        defaultValue: '000000000',
      ),
      projectId: String.fromEnvironment(
        'FIREBASE_PROJECT_ID',
        defaultValue: 'demo-checkpoint',
      ),
    ),
  );

  // 3. Conecta aos Emuladores Locais (Auth: 9099, Firestore: 8080)
  try {
    // No Emulador Android usamos '10.0.2.2'; no Windows/Web usamos 'localhost'
    final emulatorHost = Platform.isAndroid ? '10.0.2.2' : 'localhost';

    FirebaseAuth.instance.useAuthEmulator(emulatorHost, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);

    print('Conectado aos emuladores do Firebase com sucesso!');
  } catch (e) {
    print('Erro ao conectar aos emuladores: $e');
  }

  runApp(const MeuAplicativo());
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab Encontro 01',
      // Agora o app aponta para o AuthGate, que decide se exibe o Login ou o Painel
      home: AuthGate(),
    );
  }
}
