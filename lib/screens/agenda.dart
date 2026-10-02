import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/notificacoes.dart';

const Color vittaBlue = Color(0xFF3B82F6);
const Color vittaGreen = Color(0xFF10B981);
const Color vittaBackground = Color(0xFFF9FAFB);

bool _sameDate(DateTime first, DateTime second) {
  return first.year == second.year &&
      first.month == second.month &&
      first.day == second.day;
}

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  String _selectedPet = 'Thor';

  final DateTime _today = DateTime(2026, 10, 5);

  final List<Map<String, dynamic>> _pets = [
    {
      'nome': 'Thor',
      'raca': 'Golden Retriever',
      'eventos': [
        {
          'tipo': 'Vacina',
          'titulo': 'Vacina V10',
          'descricao': 'Aplicação da vacina',
          'data': DateTime(2026, 10, 6),
          'horario': '10:00',
          'cor': vittaBlue,
          'icone': Icons.vaccines_outlined,
        },
        {
          'tipo': 'Medicamento',
          'titulo': 'Antipulgas & Carrapatos',
          'descricao': 'NexGard',
          'data': DateTime(2026, 10, 12),
          'horario': '08:00',
          'cor': vittaGreen,
          'icone': Icons.shield_outlined,
        },
        {
          'tipo': 'Medicamento',
          'titulo': 'Vermífugo',
          'descricao': 'Drontal',
          'data': DateTime(2026, 10, 17),
          'horario': '11:00',
          'cor': vittaGreen,
          'icone': Icons.medication_outlined,
        },
        {
          'tipo': 'Vacina',
          'titulo': 'Vacina Antirrábica',
          'descricao': 'Aplicação da vacina',
          'data': DateTime(2026, 10, 20),
          'horario': '09:00',
          'cor': vittaBlue,
          'icone': Icons.vaccines_outlined,
        },
      ],
    },
    {
      'nome': 'Luna',
      'raca': 'Gata Siamesa',
      'eventos': [
        {
          'tipo': 'Vacina',
          'titulo': 'Vacina Antirrábica',
          'descricao': 'Aplicação da vacina',
          'data': DateTime(2026, 10, 10),
          'horario': '09:00',
          'cor': vittaBlue,
          'icone': Icons.vaccines_outlined,
        },
        {
          'tipo': 'Medicamento',
          'titulo': 'Antiparasitário',
          'descricao': 'Aplicação do antiparasitário',
          'data': DateTime(2026, 10, 15),
          'horario': '14:00',
          'cor': vittaGreen,
          'icone': Icons.shield_outlined,
        },
        {
          'tipo': 'Vacina',
          'titulo': 'Vacina V10',
          'descricao': 'Aplicação da vacina',
          'data': DateTime(2026, 10, 19),
          'horario': '10:00',
          'cor': vittaBlue,
          'icone': Icons.vaccines_outlined,
        },
        {
          'tipo': 'Medicamento',
          'titulo': 'Vermífugo',
          'descricao': 'Drontal',
          'data': DateTime(2026, 10, 27),
          'horario': '08:00',
          'cor': vittaGreen,
          'icone': Icons.medication_outlined,
        },
      ],
    },
  ];

  DateTime _selectedDate = DateTime(2026, 10, 5);

  Map<String, dynamic> get _petAtual {
    return _pets.firstWhere(
      (pet) => pet['nome'] == _selectedPet,
    );
  }

  List<Map<String, dynamic>> get _eventos {
    return List<Map<String, dynamic>>.from(
      _petAtual['eventos'],
    );
  }

  List<Map<String, dynamic>> get _vacinas {
    return _eventos
        .where((evento) => evento['tipo'] == 'Vacina')
        .toList();
  }

  List<Map<String, dynamic>> get _medicamentos {
    return _eventos
        .where((evento) => evento['tipo'] == 'Medicamento')
        .toList();
  }

  List<Map<String, dynamic>> get _eventosSelecionados {
    return _eventos.where((evento) {
      return _sameDate(
        evento['data'],
        _selectedDate,
      );
    }).toList();
  }

  void _abrirNotificacoes() {
    Notificacoes.abrir(context);
  }

  void _selecionarPet(String pet) {
    setState(() {
      _selectedPet = pet;
      _selectedDate = _today;
    });
  }

  void _selecionarData(DateTime data) {
    setState(() {
      _selectedDate = data;
    });
  }

  void _adicionarCuidado() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adicionar cuidado',
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Aqui você poderá cadastrar um novo cuidado para $_selectedPet.',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: vittaBlue,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Cadastro completo será conectado ao banco de dados posteriormente.',
                          style: GoogleFonts.nunito(
                            fontSize: 12,
                            color: const Color(0xFF374151),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: vittaBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),
            SliverToBoxAdapter(
              child: _buildPetSelector(),
            ),
            SliverToBoxAdapter(
              child: _buildSummary(),
            ),
            SliverToBoxAdapter(
              child: _buildCalendar(),
            ),
            SliverToBoxAdapter(
              child: _buildSelectedDay(),
            ),
            SliverToBoxAdapter(
              child: _buildUpcoming(),
            ),
            SliverToBoxAdapter(
              child: _buildAddButton(),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Agenda',
                  style: GoogleFonts.nunito(
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Acompanhe os cuidados do seu pet',
                  style: GoogleFonts.nunito(
                    fontSize: 13,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _abrirNotificacoes,
            child: Container(
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
                        color: Color(0xFFF59E0B),
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
    );
  }

  Widget _buildPetSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 18),
      child: Row(
        children: _pets.map((pet) {
          final String nome = pet['nome'];
          final bool selecionado = nome == _selectedPet;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: nome == 'Thor' ? 8 : 0,
              ),
              child: GestureDetector(
                onTap: () => _selecionarPet(nome),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: selecionado
                        ? vittaBlue
                        : Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: selecionado
                          ? vittaBlue
                          : const Color(0xFFE5E7EB),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      nome,
                      style: GoogleFonts.nunito(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: selecionado
                            ? Colors.white
                            : const Color(0xFF374151),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 18),
      child: Row(
        children: [
          Expanded(
            child: _summaryCard(
              icon: Icons.vaccines_outlined,
              title: 'Vacinas',
              value: '${_vacinas.length}',
              color: vittaBlue,
              background: const Color(0xFFEFF6FF),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _summaryCard(
              icon: Icons.medication_outlined,
              title: 'Medicamentos',
              value: '${_medicamentos.length}',
              color: vittaGreen,
              background: const Color(0xFFECFDF5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required Color background,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1F2937),
                ),
              ),
              Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    final DateTime firstDay = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      1,
    );

    final int daysInMonth = DateTime(
      _selectedDate.year,
      _selectedDate.month + 1,
      0,
    ).day;

    final int firstWeekday =
        firstDay.weekday;

    final List<Widget> days = [];

    for (int i = 1; i < firstWeekday; i++) {
      days.add(const SizedBox());
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final DateTime date = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        day,
      );

      final List<Map<String, dynamic>> eventosDoDia =
          _eventos.where((evento) {
        return _sameDate(
          evento['data'],
          date,
        );
      }).toList();

      final bool selecionado =
          _sameDate(date, _selectedDate);

      final bool hoje =
          _sameDate(date, _today);

      days.add(
        _calendarDay(
          date,
          eventosDoDia,
          selecionado,
          hoje,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        18,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          14,
          16,
          14,
          14,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month - 1,
                        1,
                      );
                    });
                  },
                  icon: const Icon(
                    Icons.chevron_left_rounded,
                    color: Color(0xFF6B7280),
                  ),
                ),
                Expanded(
                  child: Text(
                    _monthName(_selectedDate.month),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month + 1,
                        1,
                      );
                    });
                  },
                  icon: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                _WeekDay('SEG'),
                _WeekDay('TER'),
                _WeekDay('QUA'),
                _WeekDay('QUI'),
                _WeekDay('SEX'),
                _WeekDay('SÁB'),
                _WeekDay('DOM'),
              ],
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 7,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
              childAspectRatio: 0.8,
              children: days,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legend(
                  color: vittaBlue,
                  label: 'Vacina',
                ),
                const SizedBox(width: 20),
                _legend(
                  color: vittaGreen,
                  label: 'Medicamento',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _calendarDay(
    DateTime date,
    List<Map<String, dynamic>> eventos,
    bool selecionado,
    bool hoje,
  ) {
    return GestureDetector(
      onTap: () => _selecionarData(date),
      child: Container(
        decoration: BoxDecoration(
          color: selecionado
              ? vittaBlue
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: hoje && !selecionado
              ? Border.all(
                  color: vittaBlue,
                  width: 1,
                )
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${date.day}',
              style: GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: selecionado
                    ? Colors.white
                    : const Color(0xFF374151),
              ),
            ),
            const SizedBox(height: 4),
            if (eventos.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: eventos.map((evento) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: selecionado
                          ? Colors.white
                          : evento['tipo'] == 'Vacina'
                              ? vittaBlue
                              : vittaGreen,
                      shape: BoxShape.circle,
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _legend({
    required Color color,
    required String label,
  }) {
    return Row(
      children: [
        Container(
          width: 7,
          height: 7,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.nunito(
            fontSize: 10,
            color: const Color(0xFF6B7280),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedDay() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _formatFullDate(_selectedDate),
            style: GoogleFonts.nunito(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 10),
          if (_eventosSelecionados.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.event_available_outlined,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _sameDate(
                        _selectedDate,
                        _today,
                      )
                          ? 'Nenhum cuidado agendado para hoje.'
                          : 'Nenhum cuidado agendado para este dia.',
                      style: GoogleFonts.nunito(
                        fontSize: 12,
                        color: const Color(0xFF6B7280),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            ..._eventosSelecionados.map(
              (evento) => Padding(
                padding: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: _eventCard(evento),
              ),
            ),
        ],
      ),
    );
  }

  Widget _eventCard(
    Map<String, dynamic> evento,
  ) {
    final Color cor = evento['cor'];

    return GestureDetector(
      onTap: () {
        _selecionarData(evento['data']);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                evento['icone'],
                color: cor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    evento['titulo'],
                    style: GoogleFonts.nunito(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    evento['descricao'],
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${_formatDate(evento['data'])} às ${evento['horario']}',
                    style: GoogleFonts.nunito(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: cor,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF9CA3AF),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcoming() {
    final List<Map<String, dynamic>> proximos = [..._eventos];

    proximos.sort(
      (a, b) => (a['data'] as DateTime)
          .compareTo(b['data'] as DateTime),
    );

    final proximosFiltrados = proximos.where((evento) {
      return (evento['data'] as DateTime)
          .isAfter(_today);
    }).take(3).toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Próximos cuidados',
            style: GoogleFonts.nunito(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 10),
          ...proximosFiltrados.map(
            (evento) => Padding(
              padding: const EdgeInsets.only(
                bottom: 10,
              ),
              child: _upcomingCard(evento),
            ),
          ),
        ],
      ),
    );
  }

  Widget _upcomingCard(
    Map<String, dynamic> evento,
  ) {
    final Color cor = evento['cor'];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
              color: cor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              evento['icone'],
              color: cor,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  evento['titulo'],
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${_formatDate(evento['data'])} às ${evento['horario']}',
                  style: GoogleFonts.nunito(
                    fontSize: 10,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: GestureDetector(
        onTap: _adicionarCuidado,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFE5E7EB),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.add,
                  color: vittaBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Adicionar cuidado',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF374151),
                  ),
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    return '${months[month - 1]} ${_selectedDate.year}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatFullDate(DateTime date) {
    const months = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    return '${date.day} de '
        '${months[date.month - 1]} '
        '${date.year}';
  }
}

class _WeekDay extends StatelessWidget {
  final String label;

  const _WeekDay(this.label);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.nunito(
            color: const Color(0xFF9CA3AF),
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}