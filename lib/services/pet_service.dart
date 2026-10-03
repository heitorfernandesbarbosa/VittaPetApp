import 'package0/cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/pet_model.dart';

class PetService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Coleção 'pets' no Firestore
  CollectionReference get _petsRef => _db.collection('pets');

  // Adicionar novo pet no Firestore
  Future<void> adicionarPet(Pet pet) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _petsRef.add({
      'nome': pet.nome,
      'especie': pet.especie,
      'raca': pet.raca,
      'idade': pet.idade,
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Buscar lista de pets do usuário logado em tempo real (Stream)
  Stream<List<Pet>> getMeusPets() {
    final user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _petsRef
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Pet.fromFirestore(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // Excluir pet
  Future<void> deletarPet(String petId) async {
    await _petsRef.doc(petId).delete();
  }
}