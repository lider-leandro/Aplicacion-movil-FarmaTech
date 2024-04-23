import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_sqlite_auth_app/Components/button.dart';
import 'package:flutter_sqlite_auth_app/Components/colors.dart';
import 'package:flutter_sqlite_auth_app/JSON/users.dart';
import 'package:flutter_sqlite_auth_app/Views/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _searchController = TextEditingController();
  int _currentImageIndex = 0;
  final List<String> _images = [
    "https://scontent.flpb3-1.fna.fbcdn.net/v/t39.30808-6/240715012_1542205106127796_3103146215831271814_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=5f2048&_nc_ohc=qYGK6dVMdg0Ab4kdyWO&_nc_ht=scontent.flpb3-1.fna&cb_e2o_trans=q&oh=00_AfB7DzmBC5R2ilh2S5-S9ix6q4w48b_fHi8UhttI85H97Q&oe=662C3AF0",
    "https://lfmopinion.com/images/assets/opinion/nota-144217133.jpg",
    "https://www.google.com/imgres?q=imagenes%20de%20publicidad%20de%20medicamentos&imgurl=https%3A%2F%2Fpreviews.123rf.com%2Fimages%2Fmacrovector%2Fmacrovector1804%2Fmacrovector180400285%2F99521146-el-cartel-antiarr%25C3%25ADtmico-cardio-con-publicidad-de-medicamentos-naturales-y-el-titular-protegen-su.jpg&imgrefurl=https%3A%2F%2Fes.123rf.com%2Fphoto_99521146_el-cartel-antiarr%25C3%25ADtmico-cardio-con-publicidad-de-medicamentos-naturales-y-el-titular-protegen-su-coraz.html&docid=FAF2VcLNlXs04M&tbnid=iEdEkp12h6PXAM&vet=12ahUKEwitloaX-tWFAxWXHbkGHfWRCrEQM3oECEYQAA..i&w=1300&h=800&hcb=2&ved=2ahUKEwitloaX-tWFAxWXHbkGHfWRCrEQM3oECEYQAA",
    "https://www.google.com/imgres?q=laboratorios%20publicidad&imgurl=https%3A%2F%2Flookaside.fbsbx.com%2Flookaside%2Fcrawler%2Fmedia%2F%3Fmedia_id%3D2463116700418194&imgrefurl=https%3A%2F%2Fwww.facebook.com%2F765547630175118%2Fposts%2Fpublicidad-h6jllaboratorio-de-analis%25C3%25ACs-cl%25C3%25ACnico-vig-labsu-laboratorio-cl%25C3%25ACnico-de-%2F2463117197084811%2F%3Flocale%3Dzh_CN&docid=GepCiyJ6_vyG5M&tbnid=or77L1dvW4hUdM&vet=12ahUKEwiklYel-NWFAxVhALkGHT-fALwQM3oECEsQAA..i&w=1080&h=1174&hcb=2&ved=2ahUKEwiklYel-NWFAxVhALkGHT-fALwQM3oECEsQAA",
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
    if(index == 2){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmaTech'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implementar la lógica de búsqueda
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar...',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Implementar la lógica de búsqueda
              },
            ),
          ),
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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 103, 31, 165), // Color morado para la barra de navegación
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket_launch),
            label: 'Lanzamientos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
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
