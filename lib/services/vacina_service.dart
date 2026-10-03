import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/vacina_model.dart';

class VacinaService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Aponta para a subcoleção de vacinas dentro do pet específico
  CollectionReference _vacinasRef(String petId) {
    return _db.collection('pets').doc(petId).collection('vacinas');
  }

  // Adicionar vacina
  Future<void> adicionarVacina(String petId, Vacina vacina) async {
    await _vacinasRef(petId).add(vacina.toMap());
  }

  // Buscar vacinas em tempo real ordenadas pela data de aplicação
  Stream<List<Vacina>> getVacinasDoPet(String petId) {
    return _vacinasRef(petId)
        .orderBy('dataAplicacao', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Vacina.fromFirestore(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }

  // Deletar vacina
  Future<void> deletarVacina(String petId, String vacinaId) async {
    await _vacinasRef(petId).doc(vacinaId).delete();
  }
}