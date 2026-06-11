import 'package:englishapp/models/canciones_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaCanciones extends StatelessWidget {
   final List<Cancion> canciones;

   const ListaCanciones({super.key, required this.canciones});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: canciones.length,
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, index) {
        final cancion = canciones[index];
        return Card(
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            title: Text(
              cancion.titulo,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Text(cancion.artista, style: TextStyle(color: Colors.grey.shade600)),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Columna Izquierda: Inglés
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('English', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                          const SizedBox(height: 8),
                          Text(cancion.estrofaIngles, style: const TextStyle(fontSize: 14, height: 1.4)),
                        ],
                      ),
                    ),
                    const VerticalDivider(width: 20),
                    // Columna Derecha: Español
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Español', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                          const SizedBox(height: 8),
                          Text(cancion.estrofaEspanol, style: const TextStyle(fontSize: 14, height: 1.4, fontStyle: FontStyle.italic)),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }


}
