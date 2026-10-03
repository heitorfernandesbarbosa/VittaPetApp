import 'package:flutter/material.dart';
import '../models/pet_model.dart';
import '../models/vacina_model.dart';
import '../services/vacina_service.dart';

class VacinasScreen extends StatefulWidget {
  final Pet pet;

  const VacinasScreen({super.key, required this.pet});

  @override
  State<VacinasScreen> createState() => _VacinasScreenState();
}

class _VacinasScreenState extends State<VacinasScreen> {
  void _exibirDialogCadastro() {
    final nomeController = TextEditingController();
    DateTime dataSelecionada = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Registrar Vacina'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome da Vacina (ex: Raiva, V10)',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nomeController.text.isNotEmpty && widget.pet.id != null) {
                  final novaVacina = Vacina(
                    nome: nomeController.text.trim(),
                    dataAplicacao: dataSelecionada,
                  );
                  await VacinaService().adicionarVacina(
                    widget.pet.id!,
                    novaVacina,
                  );
                  if (mounted) Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vacinas de ${widget.pet.nome}'),
      ),
      body: StreamBuilder<List<Vacina>>(
        stream: VacinaService().getVacinasDoPet(widget.pet.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Nenhuma vacina registrada para este pet.'),
            );
          }

          final vacinas = snapshot.data!;

          return ListView.builder(
            itemCount: vacinas.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final vacina = vacinas[index];
              final dataFmt =
                  '${vacina.dataAplicacao.day}/${vacina.dataAplicacao.month}/${vacina.dataAplicacao.year}';

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.vaccines, color: Colors.teal),
                  title: Text(vacina.nome),
                  subtitle: Text('Aplicada em: $dataFmt'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      if (widget.pet.id != null && vacina.id != null) {
                        await VacinaService().deletarVacina(
                          widget.pet.id!,
                          vacina.id!,
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _exibirDialogCadastro,
        icon: const Icon(Icons.add),
        label: const Text('Nova Vacina'),
      ),
    );
  }
}