import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LaboratoriosScreen extends StatefulWidget {
  @override
  _LaboratoriosScreenState createState() => _LaboratoriosScreenState();
}

class _LaboratoriosScreenState extends State<LaboratoriosScreen> {
  final CollectionReference laboratorios =
      FirebaseFirestore.instance.collection('laboratorios');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laboratorios'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: laboratorios.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
              if(data == null) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF2DB184),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.warning, color: Colors.white, size: 30.0),
                    title: Text('Sin datos', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  ),
                );
              }
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFF2DB184),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  leading: Icon(Icons.local_hospital, color: Colors.white, size: 30.0),
                  title: Text(data['nombre'] ?? 'Sin nombre', style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['descripcion'] ?? 'Sin descripción', style: TextStyle(color: Colors.white)),
                      Text('Ubicación: ${data['ubicacion'] ?? 'Sin ubicación'}', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  // Agrega aquí más elementos de laboratorio que desees mostrar
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
