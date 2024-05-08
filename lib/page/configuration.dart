import 'package:FarmaTech/views/verificacion.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfiguracionScreen extends StatelessWidget {
  final User user;

  ConfiguracionScreen({required this.user});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: NetworkImage(user.photoURL!),
              radius: 60,
              backgroundColor: Colors.transparent,
            ),
            SizedBox(height: 20),
            Text(
              'Hola, ${user.displayName ?? ''}!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              'Correo electrónico: ${user.email ?? ''}',
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return AuthenticationWrapper();
                      },
                    ),
                  );
                } catch (e) {
                  print("Error al cerrar sesión: $e");
                }
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
