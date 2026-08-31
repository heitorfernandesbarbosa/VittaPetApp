import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const VittaPetApp());
}

class VittaPetApp extends StatelessWidget {
  const VittaPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VittaPet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          primary: const Color(0xFF3B82F6),
          secondary: const Color(0xFF10B981),
        ),
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        useMaterial3: true,

        // Tipografia oficial do VittaPet
        textTheme: GoogleFonts.nunitoTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _selectedPet = 'Thor (Golden Retriever)';

  final List<String> _pets = [
    'Thor (Golden Retriever)',
    'Luna (Gato Siamês)',
    'Mel (SRD)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'vittapet-logo.png',
              width: 38,
              height: 38,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Text(
              'VittaPet',
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF4B5563),
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seletor de Pet
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
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
                    color: Color(0xFF3B82F6),
                  ),
                  items: _pets.map((String pet) {
                    return DropdownMenuItem<String>(
                      value: pet,
                      child: Text(
                        pet,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF374151),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedPet = newValue;
                      });
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Card Principal: Próximo Alerta
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF3B82F6),
                    Color(0xFF2563EB),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Próximo Lembrete',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.alarm,
                        color: Colors.white,
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Vacina V10 (Múltipla)',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    'Agendado para: Amanhã às 10:00',
                    style: TextStyle(
                      color: Color(0xFFE0E7FF),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Ações Rápidas
            const Text(
              'Ações Rápidas',
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
                  const Color(0xFF3B82F6),
                ),
                _buildActionButton(
                  Icons.medication,
                  'Remédios',
                  const Color(0xFF10B981),
                ),
                _buildActionButton(
                  Icons.volunteer_activism,
                  'Adoção',
                  const Color(0xFFF59E0B),
                ),
                _buildActionButton(
                  Icons.badge,
                  'Carteirinha',
                  const Color(0xFF10B981),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Lembretes Pendentes
            const Text(
              'Próximas Doses & Cuidados',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 12),

            _buildReminderCard(
              'Antipulgas & Carrapatos',
              'Em 5 dias • NexGard',
              Icons.shield_outlined,
              const Color(0xFF10B981),
            ),

            const SizedBox(height: 10),

            _buildReminderCard(
              'Vermífugo Periódico',
              'Em 12 dias • Drontal',
              Icons.healing_outlined,
              const Color(0xFFF59E0B),
            ),

            const SizedBox(height: 24),

            // Banner Adoção Responsável
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFBFDBFE),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Color(0xFFF59E0B),
                    size: 32,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Espaço Adoção',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        Text(
                          'Conheça pets que precisam de um lar!',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Ver Feed',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3B82F6),
        unselectedItemColor: const Color(0xFF9CA3AF),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Adoção',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            icon,
            color: color,
            size: 28,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4B5563),
          ),
        ),
      ],
    );
  }

  Widget _buildReminderCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 22,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: Color(0xFF9CA3AF),
          ),
        ],
      ),
    );
  }
}