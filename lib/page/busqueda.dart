import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Medicamento> _medicamentos = [
    Medicamento(
      nombre: 'Paracetamol',
      descripcion: 'Medicamento para aliviar el dolor y reducir la fiebre.',
      presentacion: 'Tabletas de 500 mg',
    ),
    Medicamento(
      nombre: 'Ibuprofeno',
      descripcion:
          'Medicamento antiinflamatorio no esteroideo (AINE) que se usa para aliviar el dolor, la inflamación y la fiebre.',
      presentacion: 'Tabletas de 400 mg',
    ),
    Medicamento(
      nombre: 'Aspirina',
      descripcion:
          'Medicamento antiinflamatorio no esteroideo (AINE) que se usa para aliviar el dolor, la inflamación y la fiebre.',
      presentacion: 'Tabletas de 100 mg',
    ),
    Medicamento(
      nombre: 'Omeprazol',
      descripcion:
          'Medicamento que disminuye la cantidad de ácido producido en el estómago.',
      presentacion: 'Cápsulas de 20 mg',
    ),
    Medicamento(
      nombre: 'Amoxicilina',
      descripcion:
          'Antibiótico que se utiliza para tratar infecciones bacterianas.',
      presentacion: 'Cápsulas de 500 mg',
    ),
    Medicamento(
      nombre: 'Loratadina',
      descripcion:
          'Antihistamínico utilizado para aliviar los síntomas de la alergia.',
      presentacion: 'Tabletas de 10 mg',
    ),
    Medicamento(
      nombre: 'Dipirona',
      descripcion:
          'Medicamento para aliviar el dolor y bajar la fiebre. También se usa como analgésico y antipirético.',
      presentacion: 'Solución inyectable de 50 mg/ml',
    ),
    Medicamento(
      nombre: 'Dexametasona',
      descripcion:
          'Corticoesteroide que se utiliza para tratar diversas afecciones, como inflamaciones, alergias y trastornos inmunológicos.',
      presentacion: 'Tabletas de 4 mg',
    ),
    Medicamento(
      nombre: 'Ranitidina',
      descripcion:
          'Antagonista del receptor H2 que se utiliza para reducir la producción de ácido en el estómago.',
      presentacion: 'Tabletas de 150 mg',
    ),
    Medicamento(
      nombre: 'Prednisona',
      descripcion:
          'Corticoesteroide que se utiliza para tratar diversas afecciones, como inflamaciones, alergias y trastornos autoinmunitarios.',
      presentacion: 'Tabletas de 5 mg',
    ),
    Medicamento(
      nombre: 'Dextrometorfano',
      descripcion:
          'Antitusivo utilizado para el alivio temporal de la tos no productiva o seca.',
      presentacion: 'Jarabe de 15 mg/5 ml',
    ),
    Medicamento(
      nombre: 'Acetaminofén',
      descripcion:
          'Analgésico y antipirético utilizado para aliviar el dolor y reducir la fiebre.',
      presentacion: 'Tabletas de 500 mg',
    ),
    Medicamento(
      nombre: 'Diclofenaco',
      descripcion:
          'Medicamento antiinflamatorio no esteroideo (AINE) que se utiliza para aliviar el dolor y reducir la inflamación.',
      presentacion: 'Tabletas de 50 mg',
    ),
    Medicamento(
      nombre: 'Hidroxicloroquina',
      descripcion:
          'Medicamento utilizado para tratar o prevenir la malaria y para tratar enfermedades autoinmunitarias como el lupus y la artritis reumatoide.',
      presentacion: 'Tabletas de 200 mg',
    ),
    Medicamento(
      nombre: 'Hidrocodona',
      descripcion:
          'Analgésico opioide que se utiliza para aliviar el dolor moderado a severo.',
      presentacion: 'Tabletas de 5 mg',
    ),
  ];
  List<Medicamento> _filteredMedicamentos = [];

  @override
  void initState() {
    super.initState();
    _filteredMedicamentos = _medicamentos;
  }

  void _filtrarMedicamentos(String query) {
    setState(() {
      _filteredMedicamentos = _medicamentos
          .where((medicamento) =>
              medicamento.nombre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajustes',
          style: TextStyle(color: Color(0xFF2DB184)),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filtrarMedicamentos,
              decoration: InputDecoration(
                hintText: 'Buscar medicamentos...',
                prefixIcon: Icon(Icons.search, color: Color(0xFF2DB184)),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMedicamentos.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(
                      _filteredMedicamentos[index].nombre,
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
                          _filteredMedicamentos[index].descripcion,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          'Presentación: ${_filteredMedicamentos[index].presentacion}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalleMedicamentoScreen(
                            medicamento: _filteredMedicamentos[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class Medicamento {
  final String nombre;
  final String descripcion;
  final String presentacion;

  Medicamento({
    required this.nombre,
    required this.descripcion,
    required this.presentacion,
  });
}

class DetalleMedicamentoScreen extends StatelessWidget {
  final Medicamento medicamento;

  DetalleMedicamentoScreen({required this.medicamento});

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Color(0xFF2DB184)),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Descripción:',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xFF2DB184)),
                ),
                SizedBox(height: 10.0),
                Text(
                  medicamento.descripcion,
                  style: TextStyle(fontSize: 20.0, color: Colors.black87),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Presentación:',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Color(0xFF2DB184)),
                ),
                SizedBox(height: 10.0),
                Text(
                  medicamento.presentacion,
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
