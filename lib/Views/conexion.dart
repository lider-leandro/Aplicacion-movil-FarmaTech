import 'package:mysql1/mysql1.dart';
import 'package:flutter/material.dart';

void main() async {
  // Establecer la conexión
  var settings = new ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: '',
      db: 'farmatech');
  var conn = await MySqlConnection.connect(settings);

  // Ejecutar consulta
  var results = await conn.query('SELECT * FROM usuario');
  for (var row in results) {
    print(row);
  }

  // Cerrar la conexión
  await conn.close();
}
