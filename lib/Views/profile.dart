import 'package:FarmaTech/page/busqueda.dart';
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
          MaterialPageRoute(builder: (context) => SettingsScreen()),
        );
        break;
      case 1:
        Navigator.pushNamed(context, '/red_screen');
        break;
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
            height: 200,
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
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () => _onItemTapped(1),
              ),
              IconButton(
                icon: Icon(Icons.medical_services),
                onPressed: () => _onItemTapped(2),
              ),
            ],
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
            icon: Icon(Icons.settings, color: Color.fromARGB(255, 208, 210, 210)),
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
