import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/home.dart';
import 'screens/agenda.dart';
import 'screens/adocao.dart';
import 'screens/perfil.dart';

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
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          primary: const Color(0xFF3B82F6),
          secondary: const Color(0xFF10B981),
        ),

        scaffoldBackgroundColor:
            const Color(0xFFF9FAFB),

        textTheme: GoogleFonts.nunitoTextTheme(),

        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),

      home: const VittaPetNavigation(),
    );
  }
}

// ================================================================
// NAVEGAÇÃO PRINCIPAL
// ================================================================

class VittaPetNavigation extends StatefulWidget {
  const VittaPetNavigation({super.key});

  @override
  State<VittaPetNavigation> createState() =>
      _VittaPetNavigationState();
}

class _VittaPetNavigationState
    extends State<VittaPetNavigation> {
  int _selectedIndex = 0;

  // ==============================================================
  // TELAS
  // ==============================================================

  final List<Widget> _screens = const [
    HomePage(),
    AgendaPage(),
    AdocaoPage(),
    PerfilPage(),
  ];

  // ==============================================================
  // TROCAR ABA
  // ==============================================================

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // ==============================================================
  // BUILD
  // ==============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      // ============================================================
      // NAVEGAÇÃO INFERIOR
      // ============================================================

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
        ),

        child: SafeArea(
          child: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,

            backgroundColor: Colors.white,
            elevation: 0,

            indicatorColor:
                Color(0xFFEFF6FF),

            height: 68,

            labelTextStyle:
                WidgetStatePropertyAll(
              TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),

            destinations: const [
              // ----------------------------------------------------
              // INÍCIO
              // ----------------------------------------------------

              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                ),
                selectedIcon: Icon(
                  Icons.home,
                ),
                label: 'Início',
              ),

              // ----------------------------------------------------
              // AGENDA
              // ----------------------------------------------------

              NavigationDestination(
                icon: Icon(
                  Icons.calendar_month_outlined,
                ),
                selectedIcon: Icon(
                  Icons.calendar_month,
                ),
                label: 'Agenda',
              ),

              // ----------------------------------------------------
              // ADOÇÃO
              // ----------------------------------------------------

              NavigationDestination(
                icon: Icon(
                  Icons.favorite_border,
                ),
                selectedIcon: Icon(
                  Icons.favorite,
                ),
                label: 'Adoção',
              ),

              // ----------------------------------------------------
              // PERFIL
              // ----------------------------------------------------

              NavigationDestination(
                icon: Icon(
                  Icons.person_outline,
                ),
                selectedIcon: Icon(
                  Icons.person,
                ),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}