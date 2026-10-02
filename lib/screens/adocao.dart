import 'package:flutter/material.dart';
import '../widgets/notificacoes.dart';

class AdocaoPage extends StatefulWidget {
  const AdocaoPage({super.key});

  @override
  State<AdocaoPage> createState() => _AdocaoPageState();
}

class _AdocaoPageState extends State<AdocaoPage> {
  static const Color blue = Color(0xFF3B82F6);
  static const Color green = Color(0xFF10B981);
  static const Color orange = Color(0xFFF59E0B);
  static const Color background = Color(0xFFF9FAFB);

  String filtro = 'Todos';

  final Set<String> favoritos = {};

  final List<Map<String, dynamic>> pets = [
    {
      'nome': 'Amora',
      'tipo': 'Cão',
      'raca': 'Shih-tzu',
      'idade': '4 meses',
      'sexo': 'Fêmea',
      'local': 'São Paulo, SP',
      'imagem': 'assets/shih-tzu-amora.png',
      'descricao':
          'Filhote carinhosa, brincalhona e muito dócil.',
      'vacina':
          'Vacinas iniciais realizadas. Ainda precisa completar o protocolo de vacinação.',
      'castracao': 'Ainda não castrada por ser filhote.',
    },
    {
      'nome': 'Max',
      'tipo': 'Cão',
      'raca': 'Spitz Alemão',
      'idade': '2 anos',
      'sexo': 'Macho',
      'local': 'Santo André, SP',
      'imagem': 'assets/spitz-alemão-max.png',
      'descricao':
          'Companheiro, brincalhão e gosta muito de passear.',
      'vacina': 'Vacinação em dia.',
      'castracao': 'Castrado.',
    },
    {
      'nome': 'Mia',
      'tipo': 'Gato',
      'raca': 'Persa',
      'idade': '4 anos',
      'sexo': 'Fêmea',
      'local': 'São Bernardo do Campo, SP',
      'imagem': 'assets/persa-mia.png',
      'descricao':
          'Gatinha tranquila, carinhosa e dócil.',
      'vacina': 'Vacinação atualizada.',
      'castracao': 'Castrada.',
    },
    {
      'nome': 'Bolt',
      'tipo': 'Cão',
      'raca': 'Border Collie',
      'idade': '8 meses',
      'sexo': 'Macho',
      'local': 'Mauá, SP',
      'imagem': 'assets/border-collie-bolt.png',
      'descricao':
          'Filhote inteligente, ativo e muito brincalhão.',
      'vacina':
          'Vacinas iniciais realizadas. Ainda precisa completar o protocolo de vacinação.',
      'castracao': 'Ainda não castrado por ser filhote.',
    },
  ];

  List<Map<String, dynamic>> get petsFiltrados {
    if (filtro == 'Cães') {
      return pets.where((pet) => pet['tipo'] == 'Cão').toList();
    }

    if (filtro == 'Gatos') {
      return pets.where((pet) => pet['tipo'] == 'Gato').toList();
    }

    return pets;
  }

  @override
  Widget build(BuildContext context) {
    final lista = petsFiltrados;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Adoção',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Notificacoes.abrir(context);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: Color(0xFF374151),
                    size: 24,
                  ),
                  Positioned(
                    right: 9,
                    top: 8,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: orange,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _banner(),
            const SizedBox(height: 22),
            const Text(
              'Encontre um novo amigo',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
            const SizedBox(height: 12),
            _filtros(),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pets disponíveis',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),
                Text(
                  '${lista.length} ${lista.length == 1 ? 'pet' : 'pets'}',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...lista.map(
              (pet) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _cardPet(pet),
              ),
            ),
            const SizedBox(height: 4),
            _adocaoResponsavel(),
          ],
        ),
      ),
    );
  }

  Widget _banner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFBFDBFE),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.favorite,
              color: orange,
              size: 25,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Encontre um pet que está esperando por um novo lar.',
              style: TextStyle(
                color: Color(0xFF1E3A8A),
                fontSize: 13,
                height: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filtros() {
    return Row(
      children: [
        Expanded(child: _filtro('Todos')),
        const SizedBox(width: 8),
        Expanded(child: _filtro('Cães')),
        const SizedBox(width: 8),
        Expanded(child: _filtro('Gatos')),
      ],
    );
  }

  Widget _filtro(String nome) {
    final selecionado = filtro == nome;

    return GestureDetector(
      onTap: () {
        setState(() {
          filtro = nome;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: selecionado ? blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selecionado
                ? blue
                : const Color(0xFFE5E7EB),
          ),
        ),
        child: Text(
          nome,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: selecionado
                ? Colors.white
                : const Color(0xFF4B5563),
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _cardPet(Map<String, dynamic> pet) {
    final nome = pet['nome'] as String;
    final favorito = favoritos.contains(nome);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color(0xFFF3F4F6),
                  child: Image.asset(
                    pet['imagem'] as String,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.pets,
                          size: 60,
                          color: blue,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: green,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Disponível',
                          style: TextStyle(
                            color: green,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (favorito) {
                          favoritos.remove(nome);
                        } else {
                          favoritos.add(nome);
                        }
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        favorito
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: favorito
                            ? orange
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        nome,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                    ),
                    Text(
                      pet['tipo'] as String,
                      style: const TextStyle(
                        color: blue,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  '${pet['raca']} • ${pet['idade']} • ${pet['sexo']}',
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Color(0xFF9CA3AF),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      pet['local'] as String,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 9),
                Text(
                  pet['descricao'] as String,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => _detalhes(pet),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: blue,
                      side: const BorderSide(
                        color: blue,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(11),
                      ),
                    ),
                    child: const Text(
                      'Ver detalhes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _detalhes(Map<String, dynamic> pet) {
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
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.82,
          child: Column(
            children: [
              SizedBox(
                height: 270,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: const Color(0xFFF3F4F6),
                      child: Image.asset(
                        pet['imagem'] as String,
                        fit: BoxFit.contain,
                        errorBuilder:
                            (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.pets,
                              size: 70,
                              color: blue,
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 12,
                      right: 12,
                      child: IconButton(
                        onPressed: () =>
                            Navigator.pop(context),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet['nome'] as String,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '${pet['raca']} • ${pet['idade']} • ${pet['sexo']}',
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 18),
                      _informacao(
                        'Sobre',
                        pet['descricao'] as String,
                      ),
                      _informacao(
                        'Vacinação',
                        pet['vacina'] as String,
                      ),
                      _informacao(
                        'Castração',
                        pet['castracao'] as String,
                      ),
                      _informacao(
                        'Localização',
                        pet['local'] as String,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _informacao(String titulo, String texto) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            texto,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _adocaoResponsavel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: const Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: blue,
            size: 22,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Adoção responsável',
                  style: TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'A adoção deve ser realizada de forma responsável, considerando os cuidados, tempo e condições necessárias para oferecer uma boa vida ao pet.',
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 11,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}