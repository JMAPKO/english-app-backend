import 'package:englishapp/services/api_services.dart';
import 'package:flutter/material.dart';
import '../models/canciones_model.dart';
import '../widgets/listaCanciones.dart';

class CancionesPage extends StatefulWidget {
  const CancionesPage({super.key});

  @override
  State<CancionesPage> createState() => _CancionesPageState();
}

class _CancionesPageState extends State<CancionesPage> {
  final ApiService apiService = ApiService();
  late Future<List<Cancion>> futureCanciones;


  @override
  void initState() {
    super.initState();
    // Disparamos la petición HTTP al iniciar la pantalla
    futureCanciones = apiService.obtenerCanciones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mis Canciones para Practicar'),
          backgroundColor: Colors.deepPurple.shade100,
          actions: [
            IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                      setState(() {
                      // Volvemos a pedir a la API (traerá un orden aleatorio nuevo)
                      futureCanciones = apiService.obtenerCanciones();
                      });
                    },)
    ],),
      body: FutureBuilder<List<Cancion>>(
        future: futureCanciones,
        builder: (context, snapshot) {
        // Caso 1: La API todavía está procesando la petición
          if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
          }

      // Caso 2: Hubo un error de conexión (ej. Servidor Python apagado o IP incorrecta)
          if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
                child: Text(
                    'Error: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                    ),
                    ),
                    );}

          // Caso 3: La API respondió pero la lista está vacía
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay canciones cargadas.'));
          }

          // Caso 4: Todo salió bien, tenemos la lista de canciones
          final canciones = snapshot.data!;
          return ListaCanciones( canciones: canciones);

    })

    );
  }
}
