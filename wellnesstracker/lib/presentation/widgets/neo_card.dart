import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/utils/neomorphic_utility.dart';

class NeoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? color;
  final List<BoxShadow>? shadows;
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
                ? (color ?? (Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white)).withOpacity(0.1)
                : (color ?? Theme.of(context).scaffoldBackgroundColor),
              borderRadius: BorderRadius.circular(borderRadius),
              border: isGlass ? Border.all(color: Colors.white.withOpacity(0.2), width: 1.0) : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
