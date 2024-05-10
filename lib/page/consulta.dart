import 'package:http/http.dart' as http;

class Consulta {
  Future<void> analizarDatos() async {
    final queryParameters = {
      'SessionID': '2F0a7xBVF4nUWJpF',
    };
    final uri = Uri.https(
      'endlessmedicalapi1.p.rapidapi.com',
      '/Analyze',
      queryParameters,
    );

    final headers = {
      'X-RapidAPI-Key': '42a3ba518emshb3b8def7851cff1p108e83jsn2059ee1f5bfa',
      'X-RapidAPI-Host': 'endlessmedicalapi1.p.rapidapi.com',
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      // Procesa la respuesta aquí
      print(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}