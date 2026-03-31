import 'package:flutter/material.dart';

/// Utility class for generating core Neomorphic visual effects.
/// Provides standardized outer shadows, inner shadows, and soft gradients.
class NeoUtils {

  /// Generates the classic convex Neomorphic outer shadow.
  /// Uses separate light and dark shadow sources to simulate depth.
  static List<BoxShadow> outerShadow({
    required BuildContext context,
    double blurRadius = 8,
    double offset = 4,
    bool isPressed = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (isPressed) return [];

    return [
      BoxShadow(
        color: isDark ? Colors.black.withValues(alpha: 0.5) : Colors.grey.shade500,
        offset: Offset(offset, offset),
        blurRadius: blurRadius,
        spreadRadius: 0,
      ),
      BoxShadow(
        color: isDark ? Colors.white.withValues(alpha: 0.15) : Colors.white,
        offset: Offset(-offset, -offset),
        blurRadius: blurRadius,
        spreadRadius: 0,
      ),
    ];
  }

  /// Generates concave Neomorphic inner shadows for recessed elements like text fields.
  static List<BoxShadow> innerShadow({
    required BuildContext context,
    double blurRadius = 6,
    double offset = 3,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return [
      BoxShadow(
        color: isDark ? Colors.black.withValues(alpha: 0.5) : Colors.grey.shade500,
        offset: Offset(offset, offset),
        blurRadius: blurRadius,
        spreadRadius: -blurRadius / 2,
      ),
      BoxShadow(
        color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white,
        offset: Offset(-offset, -offset),
        blurRadius: blurRadius,
        spreadRadius: -blurRadius / 2,
      ),
    ];
  }

  /// Generates a subtle Neomorphic gradient to simulate directional surface lighting.
  static LinearGradient neoGradient({
    required BuildContext context,
    bool isPressed = false,
  }) {
    final theme = Theme.of(context);
    final baseColor = theme.scaffoldBackgroundColor;

    if (isPressed) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          baseColor.withValues(alpha: 0.8),
          baseColor,
        ],
      );
    }

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [baseColor, baseColor],
    );
  }
}
