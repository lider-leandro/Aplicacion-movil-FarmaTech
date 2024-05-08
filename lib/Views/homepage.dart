import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './verificacion.dart';

class HomePage extends StatelessWidget {
  final User user;

  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) {
                        return MyHomePage();
                      },
                    ),
                  );
                });
              },
              child: Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}