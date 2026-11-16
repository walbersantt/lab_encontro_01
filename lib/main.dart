import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Importa a tela inicial (AuthGate)
import 'views/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase lendo as variáveis do arquivo JSON
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: String.fromEnvironment('FIREBASE_API_KEY'),
      appId: String.fromEnvironment('FIREBASE_APP_ID'),
      messagingSenderId: String.fromEnvironment('FIREBASE_SENDER_ID'),
      projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
    ),
  );

  // Configura os emuladores (Web usa 127.0.0.1, Android usa 10.0.2.2)
  if (kIsWeb) {
    FirebaseAuth.instance.useAuthEmulator('127.0.0.1', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
  } else {
    FirebaseAuth.instance.useAuthEmulator('10.0.2.2', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('10.0.2.2', 8080);
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
      // Aponta para o AuthGate, que decide se mostra o Login ou a Lista
      home: AuthGate(),
    );
  }
}