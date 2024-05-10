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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MedicamentosScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConsultaScreen()),
        );
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LaboratoriosScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmaTech'),
        backgroundColor: Color.fromRGBO(45, 177, 132, 1.0),
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
                    _onItemTapped(0);
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
                    _onItemTapped(1);
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
                    _onItemTapped(2);
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
                    // Acción al presionar el icono de restricción para embarazadas
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF2DB184),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 142, 160, 154)),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket, color: Color.fromARGB(255, 247, 249, 248)),
            label: 'Lanzamientos',
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.settings, color: Color.fromARGB(255, 208, 210, 210)),
            label: 'Ajustes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
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
              // Navigate to lanzamientos screen
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ConfiguracionScreen(
                        user: FirebaseAuth.instance.currentUser!)),
              );
              // Navigate to ajustes screen
              break;
          }
        },
      ),
    );
  }
}
