import 'package:FarmaTech/views/verificacion.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './publicidad.dart';
import './lanzamientos.dart';

class ConfiguracionScreen extends StatelessWidget {
  final User user;
  int _selectedIndex = 0;

  ConfiguracionScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuración',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 246, 246, 246),
          ),
        ),
        backgroundColor: Color(0xFF2DB184),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2DB184)!,
              Color.fromARGB(255, 240, 240, 240)!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60),
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 20),
              Text(
                'Hola, ${user.displayName ?? ''}!',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Correo electrónico: ${user.email ?? ''}',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2DB184),
                  textStyle: TextStyle(
                        color: Colors.white,
                      ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.teal[400]),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.rocket, color: Colors.teal[400]),
                label: 'Lanzamientos',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings, color: Colors.teal[400]),
                label: 'Ajustes',
              ),
            ],
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            unselectedLabelStyle: TextStyle(
              color: Colors.grey,
            ),
            selectedLabelStyle: TextStyle(
              color: Colors.teal[400],
            ),
            onTap: (index) {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Lanzamiento()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfiguracionScreen(
                        user: FirebaseAuth.instance.currentUser!,
                      ),
                    ),
                  );
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}