class Cancion {
  final int? id;
  final String titulo;
  final String artista;
  final String estrofaIngles;
  final String estrofaEspanol;

  Cancion({
    this.id,
    required this.titulo,
    required this.artista,
    required this.estrofaIngles,
    required this.estrofaEspanol
  });

  // El "Constructor de fábrica" que toma el JSON (Map) de Python y lo convierte en Objeto Dart
  factory Cancion.fromJson(Map<String, dynamic> json) {
    return Cancion(
      id: json['id'],
      titulo: json['titulo'] ?? 'Sin Título',
      artista: json['artista'] ?? 'Artista Desconocido',
      estrofaIngles: json['estrofa_ingles'] ?? '',
      estrofaEspanol: json['estrofa_espanol'] ?? ''
    );
  }



}