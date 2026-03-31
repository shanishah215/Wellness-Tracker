import 'dart:ui';
import 'package:flutter/material.dart';

/// A background widget that creates a modern Glassmorphism effect.
/// It uses soft, blurred glowing orbs placed behind a heavy backdrop blur.
class NeoBackground extends StatelessWidget {
  /// The main content to display above the background.
  final Widget child;

  const NeoBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        // Top-right glowing orb
        Positioned(
          top: -100,
          right: -50,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent.withValues(alpha: 0.25),
            ),
          ),
        ),
        // Bottom-left glowing orb
        Positioned(
          bottom: -50,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.primaryColor.withValues(alpha: 0.2),
            ),
          ),
        ),
        // Floating center orb
        Positioned(
          top: size.height * 0.4,
          right: size.width * 0.2,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.purpleAccent.withValues(alpha: 0.15),
            ),
          ),
        ),
        // Heavy blur layer to blend the orbs
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: const SizedBox.shrink(),
          ),
        ),
        // Foreground content
        Positioned.fill(child: child),
      ],
    );
  }
}
