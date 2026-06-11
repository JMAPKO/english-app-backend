
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:englishapp/models/canciones_model.dart';

class ApiService {
  // IP puente para el emulador de Android Studio hacia tu localhost:8000
  static const String baseUrl = 'http://10.0.2.2:8000';


  Future<List<Cancion>> obtenerCanciones() async {

    final url = Uri.parse('$baseUrl/canciones');

    try{
      final response = await http.get(url);

      if(response.statusCode == 200){
        final String respuestaDeco = utf8.decode(response.bodyBytes);
        final List<dynamic> jsonList = jsonDecode(respuestaDeco);

        return jsonList.map((json) => Cancion.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar canciones: ${response.statusCode}');
      }
    } catch(e){
      throw Exception('No se pudo conectar con el servidor: $e');
    }



  }

}