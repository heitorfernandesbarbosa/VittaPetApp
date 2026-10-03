import 'package:cloud_firestore/cloud_firestore.dart';

class Vacina {
  final String? id;
  final String nome;
  final DateTime dataAplicacao;
  final DateTime? proximaDose;

  Vacina({
    this.id,
    required this.nome,
    required this.dataAplicacao,
    this.proximaDose,
  });

  // Converter do Firestore para o modelo Dart
  factory Vacina.fromFirestore(String id, Map<String, dynamic> map) {
    return Vacina(
      id: id,
      nome: map['nome'] ?? '',
      dataAplicacao: (map['dataAplicacao'] as Timestamp).toDate(),
      proximaDose: map['proximaDose'] != null
          ? (map['proximaDose'] as Timestamp).toDate()
          : null,
    );
  }

  // Converter para mapa e salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'dataAplicacao': Timestamp.fromDate(dataAplicacao),
      'proximaDose': proximaDose != null ? Timestamp.fromDate(proximaDose!) : null,
      'createdAt': FieldValue.serverTimestamp(),
    };
  }
}