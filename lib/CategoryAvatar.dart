import 'package:flutter/material.dart';

class CategoryAvatar extends StatelessWidget {
  final String title;
  final double size;

  const CategoryAvatar({
    super.key,
    required this.title,
    this.size = 50.0,
  });

  IconData? _getIconForTitle(String text) {
    final lower = text.toLowerCase();
    if (lower.contains('food') || lower.contains('cook') || lower.contains('recipe') || lower.contains('dish')) {
      return Icons.fastfood_rounded;
    } else if (lower.contains('it') || lower.contains('code') || lower.contains('tech') || lower.contains('computer') || lower.contains('prog')) {
      return Icons.computer_rounded;
    } else if (lower.contains('math') || lower.contains('calc') || lower.contains('algebra')) {
      return Icons.calculate_rounded;
    } else if (lower.contains('science') || lower.contains('chem') || lower.contains('bio') || lower.contains('physics')) {
      return Icons.science_rounded;
    } else if (lower.contains('history') || lower.contains('geo') || lower.contains('world')) {
      return Icons.public_rounded;
    } else if (lower.contains('art') || lower.contains('music') || lower.contains('paint')) {
      return Icons.palette_rounded;
    } else if (lower.contains('sport') || lower.contains('fit') || lower.contains('gym')) {
      return Icons.sports_soccer_rounded;
    } else if (lower.contains('english') || lower.contains('lang') || lower.contains('word') || lower.contains('vocab')) {
      return Icons.translate_rounded;
    }
    return null;
  }

  Color _getDeterministicColor(String text) {
    final colors = [
      const Color(0xFFE53935),
      const Color(0xFF1E88E5),
      const Color(0xFF43A047),
      const Color(0xFFFB8C00),
      const Color(0xFF8E24AA),
      const Color(0xFF00ACC1),
      const Color(0xFF6D4C41),
    ];
    if (text.isEmpty) return colors[0];
    return colors[text.codeUnits.reduce((a, b) => a + b) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final icon = _getIconForTitle(title);
    final accentColor = _getDeterministicColor(title);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.4), width: 1.5),
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, color: accentColor, size: size * 0.5)
            : Text(
          title.isNotEmpty ? title[0].toUpperCase() : '?',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: size * 0.45,
            color: accentColor,
          ),
        ),
      ),
    );
  }
}
