import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicamentosScreen extends StatefulWidget {
  @override
  _MedicamentosScreenState createState() => _MedicamentosScreenState();
}

class _MedicamentosScreenState extends State<MedicamentosScreen> {
  List<dynamic> medicamentos = [];
  List<dynamic> medicamentosFiltrados = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMedicamentos();
  }

  Future<void> fetchMedicamentos() async {
    final String url = 'https://api.fda.gov/drug/label.json?limit=200';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        medicamentos = data['results'];
        medicamentosFiltrados = medicamentos;
      });
    } else {
      print('Error al obtener los medicamentos: ${response.statusCode}');
    }
  }

  Future<String> translateToSpanish(String text) async {
    final String apiKey = 'AIzaSyCq_XiEACRkkS_8CjeoXUnypYtX3OsDV3Y'; // Aquí colocas tu API Key
    final String url =
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey&q=$text&target=es';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['translations'][0]['translatedText'];
    } else {
      print('Error al traducir el texto: ${response.statusCode}');
      return text;
    }
  }

  void _filterMedicamentos(String query) {
    setState(() {
      medicamentosFiltrados = medicamentos.where((medicamento) {
        final openfda = medicamento['openfda'];
        final nombre = openfda?['brand_name']?[0] ?? '';
        return nombre.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Medicamentos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2DB184),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar medicamento...',
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: _filterMedicamentos,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: medicamentosFiltrados.length,
                itemBuilder: (context, index) {
                  final medicamento = medicamentosFiltrados[index];
                  final openfda = medicamento['openfda'];
                  final nombre = openfda?['brand_name']?[0];

                  // Verificar si el medicamento tiene nombre antes de mostrarlo
                  if (nombre != null) {
                    final ingredienteActivo = openfda?['generic_name']?[0];
                    final fabricante = openfda?['manufacturer_name']?[0];
                    final dosageForm = medicamento['dosage_form']?[0];

                    return GestureDetector(
                      onTap: () {
                        // Navegar a la pantalla de detalles del medicamento
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetallesMedicamentoScreen(medicamento: medicamento),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder<String>(
                                future: translateToSpanish(nombre),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Text(
                                      'Cargando...',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2DB184),
                                      ),
                                    );
                                  } else {
                                    if (snapshot.hasData) {
                                      return Text(
                                        snapshot.data!,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF2DB184),
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }
                                },
                              ),
                              SizedBox(height: 8),
                              if (ingredienteActivo != null)
                                FutureBuilder<String>(
                                  future: translateToSpanish('Ingrediente activo: $ingredienteActivo'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Text(
                                        'Cargando...',
                                        style: TextStyle(fontSize: 16, color: Colors.black87),
                                      );
                                    } else {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!,
                                          style: TextStyle(fontSize: 16, color: Colors.black87),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }
                                  },
                                ),
                              if (fabricante != null)
                                FutureBuilder<String>(
                                  future: translateToSpanish('Fabricante: $fabricante'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Text(
                                        'Cargando...',
                                        style: TextStyle(fontSize: 16, color: Colors.black87),
                                      );
                                    } else {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!,
                                          style: TextStyle(fontSize: 16, color: Colors.black87),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }
                                  },
                                ),
                              if (dosageForm != null)
                                FutureBuilder<String>(
                                  future: translateToSpanish('Forma farmacéutica: $dosageForm'),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Text(
                                        'Cargando...',
                                        style: TextStyle(fontSize: 16, color: Colors.black87),
                                      );
                                    } else {
                                      if (snapshot.hasData) {
                                        return Text(
                                          snapshot.data!,
                                          style: TextStyle(fontSize: 16, color: Colors.black87),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    // Si el medicamento no tiene nombre, retornar un contenedor vacío
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetallesMedicamentoScreen extends StatefulWidget {
  final dynamic medicamento;

  DetallesMedicamentoScreen({required this.medicamento});

  @override
  _DetallesMedicamentoScreenState createState() => _DetallesMedicamentoScreenState();
}

class _DetallesMedicamentoScreenState extends State<DetallesMedicamentoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  Future<String> translateToSpanish(String text) async {
    final String apiKey = 'AIzaSyCq_XiEACRkkS_8CjeoXUnypYtX3OsDV3Y'; // Aquí colocas tu API Key
    final String url =
        'https://translation.googleapis.com/language/translate/v2?key=$apiKey&q=$text&target=es';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['data']['translations'][0]['translatedText'];
    } else {
      print('Error al traducir el texto: ${response.statusCode}');
      return text;
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildDetail(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2DB184),
            ),
          ),
          SizedBox(height: 4),
          FutureBuilder<String>(
            future: translateToSpanish(content),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text(
                  'Cargando...',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                );
              } else {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  );
                } else {
                  return Container();
                }
              }
            },
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 1,
            height: 16,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final openfda = widget.medicamento['openfda'];
    final nombre = openfda?['brand_name']?[0];
    final ingredienteActivo = openfda?['generic_name']?[0];
    final fabricante = openfda?['manufacturer_name']?[0];
    final dosageForm = widget.medicamento['dosage_form']?[0];
    final route = openfda?['route']?[0];
    final dosageAndAdministration = widget.medicamento['dosage_and_administration']?[0];
    final indications = widget.medicamento['indications_and_usage']?[0];
    final warnings = widget.medicamento['warnings']?[0];
    final adverseReactions = widget.medicamento['adverse_reactions']?[0];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalles del Medicamento',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2DB184),
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (nombre != null)
                          Text(
                            nombre,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2DB184),
                            ),
                          ),
                        SizedBox(height: 16),
                        if (ingredienteActivo != null)
                          _buildDetail(
                            'Ingrediente Activo',
                            ingredienteActivo,
                          ),
                        if (fabricante != null)
                          _buildDetail(
                            'Fabricante',
                            fabricante,
                          ),
                        if (dosageForm != null)
                          _buildDetail(
                            'Forma Farmacéutica',
                            dosageForm,
                          ),
                        if (route != null)
                          _buildDetail(
                            'Vía de Administración',
                            route,
                          ),
                        if (dosageAndAdministration != null)
                          _buildDetail(
                            'Dosificación y Administración',
                            dosageAndAdministration,
                          ),
                        if (indications != null)
                          _buildDetail(
                            'Indicaciones',
                            indications,
                          ),
                        if (warnings != null)
                          _buildDetail(
                            'Advertencias',
                            warnings,
                          ),
                        if (adverseReactions != null)
                          _buildDetail(
                            'Reacciones Adversas',
                            adverseReactions,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}