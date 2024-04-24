import 'package:flutter/material.dart';
import 'package:flutter_sqlite_auth_app/Components/button.dart';
import 'package:flutter_sqlite_auth_app/Components/colors.dart';
import 'package:flutter_sqlite_auth_app/Views/login.dart';
import 'package:flutter_sqlite_auth_app/Views/signup.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "INICIO DE SESION",
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const Text(
                "registrate para acceder a nuestra aplicación",
                style: TextStyle(color: Colors.grey),
              ),
              Expanded(child: Image.asset("assets/fondo.jpeg")),
              Button(label: "INICIAR SESION", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
              }),
              Button(label: "CREAR CUENTA", press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignupScreen()));
              }),
            ],
          ),
        ),
      )),
    );
  }
}
