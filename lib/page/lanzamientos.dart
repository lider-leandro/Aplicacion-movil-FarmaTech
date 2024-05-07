import 'package:flutter/material.dart';

class Lanzamiento extends StatefulWidget {
  @override
  _LanzamientoState createState() => _LanzamientoState();
}

class _LanzamientoState extends State<Lanzamiento> {
  List<Medicamento> _medicamentos = [
    Medicamento(
      nombre: 'Paracetamol',
      descripcion: 'Medicamento para aliviar el dolor y reducir la fiebre.',
      presentacion: 'Tabletas de 500 mg',
      laboratorio: 'Laboratorio A',
    ),
    Medicamento(
      nombre: 'Ibuprofeno',
      descripcion:
          'Medicamento antiinflamatorio no esteroideo (AINE) que se usa para aliviar el dolor, la inflamación y la fiebre.',
      presentacion: 'Tabletas de 400 mg',
      laboratorio: 'Laboratorio B',
    ),
    Medicamento(
      nombre: 'Aspirina',
      descripcion:
          'Medicamento antiinflamatorio no esteroideo (AINE) que se usa para aliviar el dolor, la inflamación y la fiebre.',
      presentacion: 'Tabletas de 100 mg',
      laboratorio: 'Laboratorio C',
    ),
    Medicamento(
      nombre: 'Omeprazol',
      descripcion:
          'Medicamento que disminuye la cantidad de ácido producido en el estómago.',
      presentacion: 'Cápsulas de 20 mg',
      laboratorio: 'Laboratorio D',
    ),
    Medicamento(
      nombre: 'Amoxicilina',
      descripcion:
          'Antibiótico que se utiliza para tratar infecciones bacterianas.',
      presentacion: 'Cápsulas de 500 mg',
      laboratorio: 'Laboratorio E',
    ),
    Medicamento(
      nombre: 'Loratadina',
      descripcion:
          'Antihistamínico utilizado para aliviar los síntomas de la alergia.',
      presentacion: 'Tabletas de 10 mg',
      laboratorio: 'Laboratorio F',
    ),
    Medicamento(
      nombre: 'Dipirona',
      descripcion:
          'Medicamento para aliviar el dolor y bajar la fiebre. También se usa como analgésico y antipirético.',
      presentacion: 'Solución inyectable de 50 mg/ml',
      laboratorio: 'Laboratorio G',
    ),
    Medicamento(
      nombre: 'Dexametasona',
      descripcion:
          'Corticoesteroide que se utiliza para tratar diversas afecciones, como inflamaciones, alergias y trastornos inmunológicos.',
      presentacion: 'Tabletas de 4 mg',
      laboratorio: 'Laboratorio H',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lanzamiento',
          style: TextStyle(color: Color(0xFF2DB184)),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: ListView.builder(
        itemCount: _medicamentos.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              title: Text(
                _medicamentos[index].nombre,
                style: TextStyle(
                  color: Color(0xFF2DB184),
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _medicamentos[index].descripcion,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Presentación: ${_medicamentos[index].presentacion}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Text(
                    'Laboratorio: ${_medicamentos[index].laboratorio}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalleMedicamentoScreen(
                      medicamento: _medicamentos[index],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Medicamento {
  final String nombre;
  final String descripcion;
  final String presentacion;
  final String laboratorio;

  Medicamento({
    required this.nombre,
    required this.descripcion,
    required this.presentacion,
    required this.laboratorio,
  });
}

class DetalleMedicamentoScreen extends StatelessWidget {
  final Medicamento medicamento;

  DetalleMedicamentoScreen({required this.medicamento});

  final List<String> meses = [
    'Enero',
    'Febrero',
    'Marzo',
    'Abril',
    'Mayo',
    'Junio',
    'Julio',
    'Agosto',
    'Septiembre',
    'Octubre',
    'Noviembre',
    'Diciembre'
  ];

  @override
  Widget build(BuildContext context) {
    // Generar una fecha aleatoria
    final fecha = DateTime(
      2022,
      (DateTime.now().month - 3) + medicamento.nombre.length,
      DateTime.now().day + medicamento.descripcion.length,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalle del Medicamento',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2DB184),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medicamento.nombre,
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2DB184),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Descripción:',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2DB184),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  medicamento.descripcion,
                  style: TextStyle(fontSize: 20.0, color: Colors.black87),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Presentación:',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2DB184),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  medicamento.presentacion,
                  style: TextStyle(fontSize: 20.0, color: Colors.black87),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Laboratorio:',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2DB184),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  medicamento.laboratorio,
                  style: TextStyle(fontSize: 20.0, color: Colors.black87),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Fecha de fabricación:',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2DB184),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  '${fecha.day} de ${meses[fecha.month - 1]} de ${fecha.year}',
                  style: TextStyle(fontSize: 20.0, color: Colors.black87),
                ),
                SizedBox(height: 20.0),
                Center(
                  child: Image.asset(
                    'assets/aspirina.jpeg',
                    height: 200.0,
                    width: 200.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
