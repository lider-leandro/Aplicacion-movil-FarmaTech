import 'package:FarmaTech/page/consulta_screen.dart';
import 'package:FarmaTech/page/favoritos.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '../page/publicidad.dart';
import '../page/component/barra_menu_profile.dart';
import '../page/configuration.dart';
import '../page/laboratorios.dart';
import '../page/lanzamientos.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _currentImageIndex = 0;
  final List<String> _images = [
    "assets/promo1.jpeg",
    "assets/promo2.jpeg",
    "assets/promo3.jpg",
    "https://pin.it/73fa948TH",
  ];
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 4), (timer) {
      setState(() {
        _currentImageIndex = (_currentImageIndex + 1) % _images.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: AppBar(
            title: Row(
              children: [
                SizedBox(width: 60),
                Icon(Icons.medical_services, color: Colors.white),
                SizedBox(width: 7),
                Text(
                  'FarmaTech',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            backgroundColor: Color(0xFF2DB184),
            elevation: 0,
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: MenuBarra(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 300,
            width: 100,
            child: PageView.builder(
              itemCount: _images.length,
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Image.asset(
                  _images[index],
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
          SizedBox(height: 40),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Column(
                    children: [
                      Container(
                        width: 110,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.blue,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Buscar',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MedicamentosScreen()),
                    );
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Column(
                    children: [
                      Container(
                        width: 110,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Favoritos',
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConsultaScreen()),
                    );
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Column(
                    children: [
                      Container(
                        width: 110,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.medical_services,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Laboratorios',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LaboratoriosScreen()),
                    );
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Column(
                    children: [
                      Container(
                        width: 110,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.child_care,
                          color: Colors.orange,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Niños',
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LaboratoriosScreen()),
                    );
                    // Acción al presionar el icono de restricción para niños
                  },
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Column(
                    children: [
                      Container(
                        width: 110,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.pregnant_woman,
                          color: Colors.purple,
                          size: 40,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Embarazadas',
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LaboratoriosScreen()),
                    );
                    // Acción al presionar el icono de restricción para embarazadas
                  },
                ),
              ],
            ),
          ),
        ],
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
                icon: Icon(Icons.home, color: Colors.black),
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
            type: BottomNavigationBarType.fixed, // Aquí está la clave
            unselectedLabelStyle: TextStyle(
                color: Colors.teal[400]), // Estilo para los labels no seleccionados
            selectedLabelStyle: TextStyle(
                color: Colors.black), // Estilo para el label seleccionado
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
                  ); // Navigate to lanzamientos screen
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfiguracionScreen(
                        user: FirebaseAuth.instance.currentUser!,
                      ),
                    ),
                  ); // Navigate to ajustes screen
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
