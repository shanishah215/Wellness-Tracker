import 'package:flutter/material.dart';
import '../../core/utils/neomorphic_utility.dart';

/// A Neomorphic linear progress bar.
class NeoProgressBar extends StatelessWidget {
  /// Progress value between 0.0 and 1.0.
  final double progress;

  /// Height of the progress bar. Defaults to 12.
  final double height;

  /// Custom color for the progress indicator. Defaults to primary color.
  final Color? color;

  const NeoProgressBar({
    super.key,
    required this.progress,
    this.height = 12,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicatorColor = color ?? theme.primaryColor;

    return Stack(
      children: [
        // Track with inner shadow
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(height / 2),
            boxShadow: NeoUtils.innerShadow(context: context, offset: 2, blurRadius: 4),
          ),
        ),
        // Animated Progress indicator
        FractionallySizedBox(
          widthFactor: progress.clamp(0.0, 1.0),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  indicatorColor.withValues(alpha: 0.7),
                  indicatorColor,
                ],
              ),
              borderRadius: BorderRadius.circular(height / 2),
              boxShadow: [
                BoxShadow(
                  color: indicatorColor.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// A Neomorphic circular progress indicator.
class NeoCircularProgress extends StatelessWidget {
  /// Progress value between 0.0 and 1.0.
  final double progress;

  /// External size (diameter) of the widget.
  final double size;

  /// Thickness of the progress ring.
  final double strokeWidth;

  /// Optional widget to display in the center of the ring.
  final Widget? child;

  /// Optional color for the progress ring.
  final Color? color;

  const NeoCircularProgress({
    super.key,
    required this.progress,
    this.size = 150,
    this.strokeWidth = 15,
    this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track with outer shadow
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: theme.scaffoldBackgroundColor,
              boxShadow: NeoUtils.outerShadow(context: context),
            ),
          ),
          // Progress Ring
          SizedBox(
            height: size - strokeWidth,
            width: size - strokeWidth,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: strokeWidth,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(color ?? theme.primaryColor),
              strokeCap: StrokeCap.round,
            ),
          ),
          ?child,
        ],
      ),
    );
  }
}
