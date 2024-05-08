import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:FarmaTech/page/laboratorios.dart';


class MenuBarra extends StatelessWidget {
  const MenuBarra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [ //Cabecera con la información del usuario
            Container(
              color: Color(0xFF2DB184),
              padding: EdgeInsets.only(top: 120, bottom: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user?.photoURL ?? ''),
                    radius: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    user?.displayName ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user?.email ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            // Lista de opciones del menú
            ListTile(
              title: Text('Nuevos productos'),
              onTap: () {
                // Aquí colocas la acción que deseas realizar al hacer tap
              },
            ),
            ListTile(
              title: Text('Productos sin azúcar'),
              onTap: () {
                // Aquí colocas la acción que deseas realizar al hacer tap
              },
            ),
            ListTile(
              title: Text('Productos sin gluten'),
              onTap: () {
                // Aquí colocas la acción que deseas realizar al hacer tap
              },
            ),
            ListTile(
              title: Text('Laboratorios'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LaboratoriosScreen()),
                );
              },
            ),
            ListTile(
              title: Text('Riesgo del embarazo'),
              onTap: () {
                // Aquí colocas la acción que deseas realizar al hacer tap
              },
            ),
            ListTile(
              title: Text('Manual de usuario'),
              onTap: () {
                // Aquí colocas la acción que deseas realizar al hacer tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
