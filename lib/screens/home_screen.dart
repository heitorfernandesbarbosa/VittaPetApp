import 'package:flutter/material.dart';
import '../models/pet_model.dart';
import '../services/auth_service.dart';
import '../services/pet_service.dart';
import 'add_pet_screen.dart';
import 'vacinas_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('VittaPet - Meus Pets'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () => AuthService().deslogar(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Banner de boas-vindas com o e-mail do usuário
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.teal.shade50,
            child: Text(
              'Olá, ${user?.email ?? "Tutor"}!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.teal.shade900,
              ),
            ),
          ),
          // Listagem de pets em tempo real via StreamBuilder
          Expanded(
            child: StreamBuilder<List<Pet>>(
              stream: PetService().getMeusPets(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar pets: ${snapshot.error}'),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'Nenhum pet cadastrado ainda.\nClique no botão + abaixo para adicionar!',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                final pets = snapshot.data!;

                return ListView.builder(
                  itemCount: pets.length,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final pet = pets[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        // Ao clicar no card, abre a tela de vacinas do pet
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => VacinasScreen(pet: pet),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.teal.shade100,
                          child: Icon(
                            pet.especie == 'Gato'
                                ? Icons.pets
                                : Icons.sound_detection_dog,
                            color: Colors.teal.shade800,
                          ),
                        ),
                        title: Text(
                          pet.nome,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${pet.especie} • ${pet.raca} • ${pet.idade} anos\nToque para ver o histórico de vacinas',
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                          tooltip: 'Excluir pet',
                          onPressed: () async {
                            if (pet.id != null) {
                              await PetService().deletarPet(pet.id!);
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddPetScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Novo Pet'),
      ),
    );
  }
}