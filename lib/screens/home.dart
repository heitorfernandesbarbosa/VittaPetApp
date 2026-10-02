import 'package:flutter/material.dart';
import '../widgets/notificacoes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ================================================================
  // DATA-BASE DA APRESENTAÇÃO
  // ================================================================

  String _selectedPet = 'Thor';

  String? _expandedAction;

  // ================================================================
  // CORES VITTAPET
  // ================================================================

  static const Color blue = Color(0xFF3B82F6);
  static const Color green = Color(0xFF10B981);
  static const Color orange = Color(0xFFF59E0B);
  static const Color background = Color(0xFFF9FAFB);

  // ================================================================
  // DADOS DOS PETS
  // ================================================================

  final List<Map<String, dynamic>> _pets = [
    // ==============================================================
    // THOR
    // ==============================================================

    {
      'nome': 'Thor',
      'raca': 'Golden Retriever',
      'nascimento': '15/05/2022',
      'ultimaAtualizacao': '28/09/2026',

      'proximoLembrete': {
        'titulo': 'Vacina V10',
        'data': 'Amanhã às 10:00',
      },

      // ------------------------------------------------------------
      // VACINAS
      // ------------------------------------------------------------

      'vacinas': [
        {
          'titulo': 'Vacina V10',
          'data': '06/10/2026 às 10:00',
        },
        {
          'titulo': 'Vacina Antirrábica',
          'data': '20/10/2026 às 09:00',
        },
      ],

      // ------------------------------------------------------------
      // MEDICAMENTOS
      // ------------------------------------------------------------

      'remedios': [
        {
          'titulo': 'Antipulgas & Carrapatos',
          'produto': 'NexGard',
          'data': '12/10/2026 às 08:00',
        },
        {
          'titulo': 'Vermífugo',
          'produto': 'Drontal',
          'data': '17/10/2026 às 11:00',
        },
      ],

      // ------------------------------------------------------------
      // PRÓXIMOS CUIDADOS
      // ------------------------------------------------------------

      'cuidados': [
        {
          'titulo': 'Antipulgas & Carrapatos',
          'subtitulo': '12/10/2026',
          'prazo': 'Em 7 dias',
          'produto': 'NexGard',
          'icon': Icons.shield_outlined,
          'color': green,
        },
        {
          'titulo': 'Vermífugo',
          'subtitulo': '17/10/2026',
          'prazo': 'Em 12 dias',
          'produto': 'Drontal',
          'icon': Icons.medication_outlined,
          'color': green,
        },
      ],
    },

    // ==============================================================
    // LUNA
    // ==============================================================

    {
      'nome': 'Luna',
      'raca': 'Gata Siamesa',
      'nascimento': '08/09/2023',
      'ultimaAtualizacao': '28/09/2026',

      'proximoLembrete': {
        'titulo': 'Vacina Antirrábica',
        'data': '10/10/2026 às 09:00',
      },

      // ------------------------------------------------------------
      // VACINAS
      // ------------------------------------------------------------

      'vacinas': [
        {
          'titulo': 'Vacina Antirrábica',
          'data': '10/10/2026 às 09:00',
        },
        {
          'titulo': 'Vacina V10',
          'data': '19/10/2026 às 10:00',
        },
      ],

      // ------------------------------------------------------------
      // MEDICAMENTOS
      // ------------------------------------------------------------

      'remedios': [
        {
          'titulo': 'Antiparasitário',
          'produto': 'Revolution Plus',
          'data': '15/10/2026 às 14:00',
        },
        {
          'titulo': 'Vermífugo',
          'produto': 'Drontal Gatos',
          'data': '27/10/2026 às 08:00',
        },
      ],

      // ------------------------------------------------------------
      // PRÓXIMOS CUIDADOS
      // ------------------------------------------------------------

      'cuidados': [
        {
          'titulo': 'Antiparasitário',
          'subtitulo': '15/10/2026',
          'prazo': 'Em 10 dias',
          'produto': 'Revolution Plus',
          'icon': Icons.shield_outlined,
          'color': green,
        },
        {
          'titulo': 'Vermífugo',
          'subtitulo': '27/10/2026',
          'prazo': 'Em 22 dias',
          'produto': 'Drontal Gatos',
          'icon': Icons.medication_outlined,
          'color': green,
        },
      ],
    },
  ];

  // ================================================================
  // PET ATUAL
  // ================================================================

  Map<String, dynamic> get _currentPet {
    return _pets.firstWhere(
      (pet) => pet['nome'] == _selectedPet,
    );
  }

  // ================================================================
  // BUILD
  // ================================================================

  @override
  Widget build(BuildContext context) {
    final pet = _currentPet;

    return Scaffold(
      backgroundColor: background,

      // ============================================================
      // CABEÇALHO
      // ============================================================

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        titleSpacing: 16,

        title: Image.asset(
          'assets/vittapet-logo-horizontal.png',
          width: 155,
          height: 60,
          fit: BoxFit.contain,
        ),

        actions: [
          GestureDetector(
            onTap: () {
              Notificacoes.abrir(context);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
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
                    color: Color(0xFF4B5563),
                    size: 25,
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

      // ============================================================
      // CONTEÚDO
      // ============================================================

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          16,
          8,
          16,
          24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // PET SELECIONADO
            // ======================================================

            const Text(
              'Pet selecionado',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 5),

            _buildPetSelector(),

            const SizedBox(height: 20),

            // ======================================================
            // PRÓXIMO LEMBRETE
            // ======================================================

            _buildNextReminder(pet),

            const SizedBox(height: 24),

            // ======================================================
            // AÇÕES RÁPIDAS
            // ======================================================

            const Text(
              'Ações rápidas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionButton(
                  Icons.vaccines,
                  'Vacinas',
                  blue,
                ),

                _buildActionButton(
                  Icons.medication,
                  'Remédios',
                  green,
                ),

                // Carteirinha continua AMARELA.
                _buildActionButton(
                  Icons.badge,
                  'Carteirinha',
                  orange,
                ),
              ],
            ),

            if (_expandedAction != null) ...[
              const SizedBox(height: 12),
              _buildExpandedAction(pet),
            ],

            const SizedBox(height: 24),

            // ======================================================
            // PRÓXIMOS CUIDADOS
            // ======================================================

            const Text(
              'Próximos cuidados',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 12),

            // PRIMEIRO MEDICAMENTO
            _buildReminderCard(
              title: pet['cuidados'][0]['titulo'],
              subtitle: pet['cuidados'][0]['subtitulo'],
              prazo: pet['cuidados'][0]['prazo'],
              produto: pet['cuidados'][0]['produto'],
              icon: pet['cuidados'][0]['icon'],
              color: green,
            ),

            const SizedBox(height: 10),

            // SEGUNDO MEDICAMENTO
            _buildReminderCard(
              title: pet['cuidados'][1]['titulo'],
              subtitle: pet['cuidados'][1]['subtitulo'],
              prazo: pet['cuidados'][1]['prazo'],
              produto: pet['cuidados'][1]['produto'],
              icon: pet['cuidados'][1]['icon'],
              color: green,
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // SELETOR DE PET
  // ================================================================

  Widget _buildPetSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedPet,
          isExpanded: true,

          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: blue,
          ),

          selectedItemBuilder: (context) {
            return _pets.map((pet) {
              return Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.pets,
                      color: blue,
                      size: 21,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet['nome'] as String,
                        style: const TextStyle(
                          color: Color(0xFF1F2937),
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      Text(
                        pet['raca'] as String,
                        style: const TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }).toList();
          },

          items: _pets.map((pet) {
            return DropdownMenuItem<String>(
              value: pet['nome'] as String,
              child: Text(
                pet['nome'] as String,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            );
          }).toList(),

          onChanged: (String? newValue) {
            if (newValue == null) {
              return;
            }

            setState(() {
              _selectedPet = newValue;
              _expandedAction = null;
            });
          },
        ),
      ),
    );
  }

  // ================================================================
  // PRÓXIMO LEMBRETE
  // ================================================================

  Widget _buildNextReminder(
    Map<String, dynamic> pet,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF3B82F6),
            Color(0xFF60A5FA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x403B82F6),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.vaccines_outlined,
              color: Colors.white,
              size: 25,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PRÓXIMO CUIDADO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  pet['proximoLembrete']['titulo']
                      as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  pet['proximoLembrete']['data']
                      as String,
                  style: const TextStyle(
                    color: Color(0xFFE0E7FF),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // BOTÕES DAS AÇÕES RÁPIDAS
  // ================================================================

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color,
  ) {
    final bool isSelected =
        _expandedAction == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (_expandedAction == label) {
            _expandedAction = null;
          } else {
            _expandedAction = label;
          }
        });
      },

      child: Container(
        width: 100,
        height: 99,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? color.withValues(alpha: 0.55)
                : const Color(0xFFE5E7EB),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
              ),
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isSelected
                    ? color.withValues(alpha: 0.18)
                    : color.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 21,
              ),
            ),

            const SizedBox(height: 7),

            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF374151),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================================================
  // AÇÕES EXPANDIDAS
  // ================================================================

  Widget _buildExpandedAction(
    Map<String, dynamic> pet,
  ) {
    switch (_expandedAction) {
      case 'Vacinas':
        return _buildExpandedCard(
          title: 'Vacinas',
          icon: Icons.vaccines,
          color: blue,
          children: [
            for (
              int i = 0;
              i < pet['vacinas'].length;
              i++
            ) ...[
              _buildExpandedItem(
                icon: Icons.vaccines,
                title:
                    pet['vacinas'][i]['titulo']
                        as String,
                subtitle:
                    pet['vacinas'][i]['data']
                        as String,
                color: blue,
              ),

              if (
                i <
                    pet['vacinas'].length - 1
              )
                const Divider(
                  height: 20,
                ),
            ],
          ],
        );

      case 'Remédios':
        return _buildExpandedCard(
          title: 'Remédios',
          icon: Icons.medication,
          color: green,
          children: [
            for (
              int i = 0;
              i < pet['remedios'].length;
              i++
            ) ...[
              _buildExpandedItem(
                icon: Icons.medication,
                title:
                    pet['remedios'][i]['titulo']
                        as String,
                subtitle:
                    '${pet['remedios'][i]['data']} • '
                    '${pet['remedios'][i]['produto']}',
                color: green,
              ),

              if (
                i <
                    pet['remedios'].length - 1
              )
                const Divider(
                  height: 20,
                ),
            ],
          ],
        );

      case 'Carteirinha':
        return _buildPetCard(pet);

      default:
        return const SizedBox.shrink();
    }
  }

  // ================================================================
  // CARD EXPANDIDO
  // ================================================================

  Widget _buildExpandedCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  borderRadius:
                      BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),

              const SizedBox(width: 10),

              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          ...children,
        ],
      ),
    );
  }

  // ================================================================
  // ITEM EXPANDIDO
  // ================================================================

  Widget _buildExpandedItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1F2937),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 3),

              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ================================================================
  // CARTEIRINHA
  // ================================================================

  Widget _buildPetCard(
    Map<String, dynamic> pet,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          // Carteirinha permanece com identidade verde
          // no conteúdo, mas o botão continua AMARELO.
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------------
          // CABEÇALHO
          // --------------------------------------------------------

          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7E6),
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.badge,
                  color: orange,
                  size: 26,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      pet['nome'] as String,
                      style: const TextStyle(
                        color: Color(0xFF1F2937),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      pet['raca'] as String,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Divider(),

          const SizedBox(height: 12),

          // --------------------------------------------------------
          // RESPONSÁVEL
          // --------------------------------------------------------

          _buildPetInfo(
            Icons.person_outline,
            'Responsável',
            'Giovanna Praieiro',
          ),

          const SizedBox(height: 12),

          // --------------------------------------------------------
          // NASCIMENTO
          // --------------------------------------------------------

          _buildPetInfo(
            Icons.cake_outlined,
            'Data de nascimento',
            pet['nascimento'] as String,
          ),

          const SizedBox(height: 16),

          // --------------------------------------------------------
          // STATUS DAS VACINAS
          // --------------------------------------------------------

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFECFDF5),
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: green,
                  size: 22,
                ),

                SizedBox(width: 10),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vacinas em dia',
                        style: TextStyle(
                          color: Color(0xFF065F46),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 2),

                      Text(
                        'Todas as vacinas estão atualizadas',
                        style: TextStyle(
                          color: Color(0xFF047857),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // --------------------------------------------------------
          // ATUALIZAÇÃO
          // --------------------------------------------------------

          Row(
            children: [
              const Icon(
                Icons.update,
                color: Color(0xFF9CA3AF),
                size: 17,
              ),

              const SizedBox(width: 7),

              const Text(
                'Última atualização: ',
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 11,
                ),
              ),

              Text(
                pet['ultimaAtualizacao'] as String,
                style: const TextStyle(
                  color: Color(0xFF374151),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================================================================
  // INFORMAÇÕES DA CARTEIRINHA
  // ================================================================

  Widget _buildPetInfo(
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF6B7280),
          size: 19,
        ),

        const SizedBox(width: 9),

        Text(
          '$label: ',
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 12,
          ),
        ),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1F2937),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  // ================================================================
  // PRÓXIMOS CUIDADOS
  // ================================================================

  Widget _buildReminderCard({
    required String title,
    required String subtitle,
    required String prazo,
    required String produto,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          // --------------------------------------------------------
          // ÍCONE
          // --------------------------------------------------------

          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: green.withValues(alpha: 0.10),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: green,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          // --------------------------------------------------------
          // NOME + DATA + PRODUTO
          // --------------------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  '$subtitle • $produto',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // --------------------------------------------------------
          // PRAZO
          // --------------------------------------------------------

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: green.withValues(alpha: 0.10),
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: Text(
              prazo,
              style: const TextStyle(
                color: Color(0xFF059669),
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}