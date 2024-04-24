import 'package:flutter/material.dart';
import 'dart:async';

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
  backgroundColor: Color.fromRGBO(45, 177, 132, 1.0), // Color del AppBar
  actions: [
    IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        // Mostrar menú emergente
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
                  // Navegar a la pantalla de inicio
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
                  // Navegar a la pantalla de favoritos
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
                  // Navegar a la pantalla de lanzamientos
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
                  // Navegar a la pantalla de ajustes
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
                    onPressed: () =>
                        _navigateToAnotherScreen(context, '/blue_screen'),
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

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
      ),
      body: Center(
        child: Text(
          'Pantalla de ajustes',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
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
