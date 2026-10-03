class Pet {
  final String? id;
  final String nome;
  final String especie;
  final String raca;
  final int idade;
  final String userId;

  Pet({
    this.id,
    required this.nome,
    required this.especie,
    required this.raca,
    required this.idade,
    required this.userId,
  });

  // Converter do Firestore para o modelo Dart
  factory Pet.fromFirestore(String id, Map<String, dynamic> map) {
    return Pet(
      id: id,
      nome: map['nome'] ?? '',
      especie: map['especie'] ?? '',
      raca: map['raca'] ?? '',
      idade: map['idade'] ?? 0,
      userId: map['userId'] ?? '',
    );
  }

  // Converter do modelo Dart para salvar no Firestore
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'especie': especie,
      'raca': raca,
      'idade': idade,
      'userId': userId,
    };
  }
}