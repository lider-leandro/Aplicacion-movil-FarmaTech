import 'package:flutter/material.dart';
import '../page/consulta.dart'; // Importa la clase Consulta

class ConsultaScreen extends StatefulWidget {
  @override
  _ConsultaScreenState createState() => _ConsultaScreenState();
}

class _ConsultaScreenState extends State<ConsultaScreen> {
  final Consulta _consulta = Consulta(); // Crea una instancia de Consulta

  @override
  void initState() {
    super.initState();
    _consulta.analizarDatos(); // Llama al método analizarDatos() de Consulta
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta'),
      ),
      body: Center(
        child: Text('Procesando consulta...'),
      ),
    );
  }
}