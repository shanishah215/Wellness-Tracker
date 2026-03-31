import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/utils/neomorphic_utility.dart';

/// A customizable card widget that supports both Neomorphic shadows and Glassmorphism effects.
class NeoCard extends StatelessWidget {
  /// The widget to display inside the card.
  final Widget child;

  /// Optional padding around the child. Defaults to EdgeInsets.all(16).
  final EdgeInsetsGeometry? padding;

  /// The radius of the card's corners. Defaults to 20.
  final double borderRadius;

  /// The background color of the card. 
  /// For glass cards, this provides a slight tint.
  final Color? color;

  /// Custom shadows to apply to the card. 
  /// If null, default Neomorphic shadows from [NeoUtils] are used.
  final List<BoxShadow>? shadows;

  /// Whether to use the Glassmorphism effect instead of Neomorphic shadows.
  final bool isGlass;

  const NeoCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20,
    this.color,
    this.shadows,
    this.isGlass = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        boxShadow: shadows ?? (isGlass ? [] : NeoUtils.outerShadow(context: context)),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: isGlass ? ImageFilter.blur(sigmaX: 10, sigmaY: 10) : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isGlass 
                ? (color ?? (isDark ? Colors.black : Colors.white)).withValues(alpha: 0.1)
                : (color ?? theme.scaffoldBackgroundColor),
              borderRadius: BorderRadius.circular(borderRadius),
              border: isGlass ? Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1.0) : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
