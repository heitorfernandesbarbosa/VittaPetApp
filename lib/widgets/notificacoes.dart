import 'package:flutter/material.dart';

class Notificacoes {
  static void abrir(BuildContext context) {
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
        return const _NotificacoesSheet();
      },
    );
  }
}

class _NotificacoesSheet extends StatelessWidget {
  const _NotificacoesSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notificações',
              style: TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Acompanhe os próximos cuidados dos seus pets.',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 20),

            _notificacao(
              icon: Icons.vaccines_outlined,
              titulo: 'Vacina V10 do Thor',
              descricao: 'Amanhã, 06/10 às 10:00',
              cor: Color(0xFF3B82F6),
              fundo: Color(0xFFEFF6FF),
            ),

            const SizedBox(height: 10),

            _notificacao(
              icon: Icons.medication_outlined,
              titulo: 'Antipulgas do Thor',
              descricao: '12/10 às 08:00',
              cor: Color(0xFF10B981),
              fundo: Color(0xFFECFDF5),
            ),

            const SizedBox(height: 10),

            _notificacao(
              icon: Icons.vaccines_outlined,
              titulo: 'Vacina Antirrábica da Luna',
              descricao: '10/10 às 09:00',
              cor: Color(0xFF3B82F6),
              fundo: Color(0xFFEFF6FF),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: Color(0xFF10B981),
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Você está em dia com os cuidados dos seus pets.',
                      style: TextStyle(
                        color: Color(0xFF4B5563),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  static Widget _notificacao({
    required IconData icon,
    required String titulo,
    required String descricao,
    required Color cor,
    required Color fundo,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
              color: fundo,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: cor,
              size: 21,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
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
        ],
      ),
    );
  }
}