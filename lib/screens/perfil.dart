import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  static const Color blue = Color(0xFF3B82F6);
  static const Color green = Color(0xFF10B981);
  static const Color background = Color(0xFFF9FAFB);

  String email = 'giovanna@gmail.com';
  String telefone = '(11) 98765-4321';
  String senha = '********';

  final List<Map<String, dynamic>> pets = [
    {
      'nome': 'Thor',
      'tipo': 'Cão',
      'raca': 'Golden Retriever',
      'nascimento': DateTime(2022, 5, 15),
    },
    {
      'nome': 'Luna',
      'tipo': 'Gato',
      'raca': 'Gata Siamesa',
      'nascimento': DateTime(2023, 9, 8),
    },
  ];

  // Data-base utilizada na apresentação do projeto.
  final DateTime dataBase = DateTime(2026, 10, 5);

  int _calcularIdade(DateTime nascimento) {
    int idade = dataBase.year - nascimento.year;

    if (dataBase.month < nascimento.month ||
        (dataBase.month == nascimento.month &&
            dataBase.day < nascimento.day)) {
      idade--;
    }

    return idade;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _configuracoesGerais,
            icon: const Icon(
              Icons.settings_outlined,
              color: Color(0xFF4B5563),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _perfilCard(),

            const SizedBox(height: 22),

            const Text(
              'Meus pets',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 12),

            ...pets.map(
              (pet) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _petCard(pet),
              ),
            ),

            _adicionarPet(),

            const SizedBox(height: 22),

            const Text(
              'Configurações',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 12),

            _configuracao(
              icon: Icons.notifications_none,
              titulo: 'Notificações',
              descricao: 'Gerencie seus lembretes',
              onTap: _notificacoes,
            ),

            const SizedBox(height: 10),

            _configuracao(
              icon: Icons.lock_outline,
              titulo: 'Privacidade e segurança',
              descricao: 'Controle seus dados e acesso',
              onTap: _privacidade,
            ),

            const SizedBox(height: 10),

            _configuracao(
              icon: Icons.help_outline,
              titulo: 'Ajuda e suporte',
              descricao: 'Encontre respostas e informações',
              onTap: _ajuda,
            ),

            const SizedBox(height: 10),

            _configuracao(
              icon: Icons.info_outline,
              titulo: 'Sobre o VittaPet',
              descricao: 'Informações sobre o aplicativo',
              onTap: _sobre,
            ),

            const SizedBox(height: 28),

            const Center(
              child: Text(
                'VittaPet • Versão 1.0.0',
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 10,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _perfilCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              color: Color(0xFFEFF6FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              color: blue,
              size: 40,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Giovanna',
            style: TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            height: 40,
            child: OutlinedButton(
              onPressed: _editarPerfil,
              style: OutlinedButton.styleFrom(
                foregroundColor: blue,
                side: const BorderSide(
                  color: blue,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Editar perfil',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _petCard(Map<String, dynamic> pet) {
    final idade = _calcularIdade(pet['nascimento']);

    return Container(
      height: 72,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: pet['tipo'] == 'Cão'
                  ? const Color(0xFFEFF6FF)
                  : const Color(0xFFECFDF5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.pets,
              color: pet['tipo'] == 'Cão' ? blue : green,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pet['nome'],
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${pet['raca']} • $idade ${idade == 1 ? 'ano' : 'anos'}',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _adicionarPet() {
    return GestureDetector(
      onTap: _adicionarNovoPet,
      child: Container(
        height: 66,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF6FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFBFDBFE),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.add,
                color: blue,
                size: 22,
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Adicionar pet',
                    style: TextStyle(
                      color: Color(0xFF1E40AF),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Cadastre um novo pet no VittaPet.',
                    style: TextStyle(
                      color: blue,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: blue,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _configuracao({
    required IconData icon,
    required String titulo,
    required String descricao,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: blue,
                size: 21,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    descricao,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Color(0xFF9CA3AF),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  void _editarPerfil() {
    final emailController = TextEditingController(text: email);
    final telefoneController = TextEditingController(text: telefone);
    final senhaController = TextEditingController(text: senha);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Editar perfil',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Atualize suas informações de acesso.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Nome',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                const TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: 'Giovanna',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'E-mail',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Telefone',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                TextField(
                  controller: telefoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Senha',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                TextField(
                  controller: senhaController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        email = emailController.text;
                        telefone = telefoneController.text;
                        senha = senhaController.text;
                      });

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Salvar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _adicionarNovoPet() {
    final nomeController = TextEditingController();
    final racaController = TextEditingController();

    String tipo = 'Cão';
    DateTime? nascimento;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom:
                    MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Adicionar pet',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Cadastre as informações do seu pet.',
                      style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Nome',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    TextField(
                      controller: nomeController,
                      decoration: const InputDecoration(
                        hintText: 'Nome do pet',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Tipo',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    DropdownButtonFormField<String>(
                      initialValue: tipo,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Cão',
                          child: Text('Cão'),
                        ),
                        DropdownMenuItem(
                          value: 'Gato',
                          child: Text('Gato'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setModalState(() {
                            tipo = value;
                          });
                        }
                      },
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Raça',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    TextField(
                      controller: racaController,
                      decoration: const InputDecoration(
                        hintText: 'Raça',
                        border: OutlineInputBorder(),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Data de nascimento',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    GestureDetector(
                      onTap: () async {
                        final data = await showDatePicker(
                          context: context,
                          initialDate: dataBase,
                          firstDate: DateTime(2000),
                          lastDate: dataBase,
                        );

                        if (data != null) {
                          setModalState(() {
                            nascimento = data;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF9CA3AF),
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          nascimento == null
                              ? 'Selecione a data'
                              : '${nascimento!.day.toString().padLeft(2, '0')}/'
                                '${nascimento!.month.toString().padLeft(2, '0')}/'
                                '${nascimento!.year}',
                          style: TextStyle(
                            color: nascimento == null
                                ? const Color(0xFF6B7280)
                                : const Color(0xFF1F2937),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          if (nomeController.text.trim().isEmpty ||
                              racaController.text.trim().isEmpty ||
                              nascimento == null) {
                            return;
                          }

                          setState(() {
                            pets.add({
                              'nome': nomeController.text.trim(),
                              'tipo': tipo,
                              'raca': racaController.text.trim(),
                              'nascimento': nascimento!,
                            });
                          });

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Salvar pet',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _notificacoes() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return const _InfoSheet(
          titulo: 'Notificações',
          icon: Icons.notifications_none,
          conteudo:
              'Gerencie os lembretes dos cuidados dos seus pets, '
              'como vacinas, medicamentos e outros cuidados agendados.',
        );
      },
    );
  }

  void _privacidade() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return const _InfoSheet(
          titulo: 'Privacidade e segurança',
          icon: Icons.lock_outline,
          conteudo:
              'Seus dados de cadastro e informações dos seus pets '
              'ficam associados ao seu perfil. Aqui também ficam '
              'as informações relacionadas ao acesso da conta.',
        );
      },
    );
  }

  void _ajuda() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return const _InfoSheet(
          titulo: 'Ajuda e suporte',
          icon: Icons.help_outline,
          conteudo:
              'Encontre informações para utilizar o VittaPet '
              'e orientações para solucionar dúvidas sobre o aplicativo.',
        );
      },
    );
  }

  void _sobre() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return const _InfoSheet(
          titulo: 'Sobre o VittaPet',
          icon: Icons.info_outline,
          conteudo:
              'VittaPet é um aplicativo para facilitar o cuidado '
              'com os pets, reunindo informações, agenda de cuidados '
              'e recursos de adoção em um só lugar.\n\n'
              'Versão 1.0.0',
        );
      },
    );
  }

  void _configuracoesGerais() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return const _InfoSheet(
          titulo: 'Configurações',
          icon: Icons.settings_outlined,
          conteudo:
              'Acesse as configurações do seu perfil, '
              'notificações, privacidade e informações do aplicativo '
              'pelas opções disponíveis nesta tela.',
        );
      },
    );
  }
}

class _InfoSheet extends StatelessWidget {
  final String titulo;
  final IconData icon;
  final String conteudo;

  const _InfoSheet({
    required this.titulo,
    required this.icon,
    required this.conteudo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      color: Color(0xFF1F2937),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Text(
              conteudo,
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 13,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}