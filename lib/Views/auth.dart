import 'package:flutter/material.dart';
import '../Components/button.dart';
import '../Components/colors.dart';
import '../Views/login.dart';
import '../Views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './homepage.dart';
import '../page/publicidad.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "FarmaTech",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "registrate para acceder a nuestra aplicación",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Image.asset(
                    "assets/fondo.jpeg",
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 40),
                Button(
                  label: "INICIAR SESION",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 0),
                Button(
                  label: "CREAR CUENTA",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    signInWithGoogle().then((user) {
                      if (user != null) {
                        // Cambiar manualmente el estado de autenticación
                        FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) {
                          if (user != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return SplashScreen();
                                },
                              ),
                            );
                          }
                        });
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2DB184),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // Establecer el ancho y el alto del botón
                    fixedSize: Size(370, 56),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/google.png', // Ruta de la imagen del logo de Google
                        height: 24, // Altura del logo de Google
                        width: 24, // Ancho del logo de Google
                      ),
                      SizedBox(width: 10), // Espacio entre el icono y el texto
                      Text(
                        'INICIAR SESION CON GOOGLE',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = authResult.user;
        return user;
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
