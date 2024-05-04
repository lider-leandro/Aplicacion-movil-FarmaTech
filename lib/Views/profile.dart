import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: Profile(),
    routes: {
      '/blue_screen': (context) => SettingsScreen(),
    },
  ));
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentImageIndex = 0;
  final List<String> _images = [
    "https://scontent.flpb3-1.fna.fbcdn.net/v/t39.30808-6/240715012_1542205106127796_3103146215831271814_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=5f2048&_nc_ohc=qYGK6dVMdg0Ab4kdyWO&_nc_ht=scontent.flpb3-1.fna&cb_e2o_trans=q&oh=00_AfB7DzmBC5R2ilh2S5-S9ix6q4w48b_fHi8UhttI85H97Q&oe=662C3AF0",
    "https://lfmopinion.com/images/assets/opinion/nota-144217133.jpg",
    "assets/publi3.png",
    "https://pin.it/73fa948TH",
  ];
  late Timer _timer;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _images.length;
      });
    });
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _navigateToAnotherScreen(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmaTech'),
        backgroundColor: Color.fromRGBO(45, 177, 132, 1.0),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(0, 50, 0, 0),
                items: [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Inicio'),
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(0);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text('Favoritos'),
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(1);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.rocket),
                      title: Text('Lanzamientos'),
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(2);
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Ajustes'),
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(3);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              children: <Widget>[
                PageView.builder(
                  itemCount: _images.length,
                  controller: PageController(initialPage: _currentImageIndex),
                  itemBuilder: (context, index) {
                    return Image.network(
                      _images[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 100),
          Expanded(
            child: SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  RoundButton(
                    color: Colors.blue,
                    iconData: Icons.search,
                    onPressed: () {
                    _navigateToAnotherScreen(context, '/settings_screen');
                    },
                    label: 'Búsqueda',
                  ),
                  RoundButton(
                    color: Colors.red,
                    iconData: Icons.favorite,
                    onPressed: () =>
                        _navigateToAnotherScreen(context, '/red_screen'),
                    label: 'Enfermedades',
                  ),
                  RoundButton(
                    color: Colors.yellow,
                    iconData: Icons.assessment,
                    onPressed: () =>
                        _navigateToAnotherScreen(context, '/yellow_screen'),
                    label: 'Síntomas',
                  ),
                  RoundButton(
                    color: Colors.purple,
                    iconData: Icons.medical_information_rounded,
                    onPressed: () =>
                        _navigateToAnotherScreen(context, '/purple_screen'),
                    label: 'Productos sin gluten',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF2DB184),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF2DB184)),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Color(0xFF2DB184)),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket, color: Color(0xFF2DB184)),
            label: 'Lanzamientos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Color(0xFF2DB184)),
            label: 'Ajustes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

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
        title: Text('Ajustes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filtrarMedicamentos,
              decoration: InputDecoration(
                hintText: 'Buscar medicamentos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMedicamentos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredMedicamentos[index].nombre),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_filteredMedicamentos[index].descripcion),
                      Text(
                          'Presentación: ${_filteredMedicamentos[index].presentacion}'),
                    ],
                  ),
                  onTap: () {
                    // Manejar la selección del medicamento
                  },
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

class RoundButton extends StatelessWidget {
  final Color color;
  final IconData iconData;
  final VoidCallback onPressed;
  final String label;

  const RoundButton({
    required this.color,
    required this.iconData,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          MaterialButton(
            color: color,
            shape: CircleBorder(),
            padding: EdgeInsets.all(20),
            onPressed: onPressed,
            child: Icon(
              iconData,
              color: Colors.white,
              size: 30,
            ),
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
