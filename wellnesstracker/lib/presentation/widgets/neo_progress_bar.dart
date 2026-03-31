import 'package:flutter/material.dart';
import '../../core/utils/neomorphic_utility.dart';

class NeoProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double height;
  final Color? color;

  const NeoProgressBar({
    super.key,
    required this.progress,
    this.height = 12,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Track
        Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(height / 2),
            boxShadow: NeoUtils.innerShadow(context: context, offset: 2, blurRadius: 4),
          ),
        ),
        // Progress
        FractionallySizedBox(
          widthFactor: progress.clamp(0.0, 1.0),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  (color ?? Theme.of(context).primaryColor).withOpacity(0.7),
                  color ?? Theme.of(context).primaryColor,
                ],
              ),
              borderRadius: BorderRadius.circular(height / 2),
              boxShadow: [
                BoxShadow(
                  color: (color ?? Theme.of(context).primaryColor).withOpacity(0.3),
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

class NeoCircularProgress extends StatelessWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Widget? child;

  const NeoCircularProgress({
    super.key,
    required this.progress,
    this.size = 150,
    this.strokeWidth = 15,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Track
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).scaffoldBackgroundColor,
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
              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
              strokeCap: StrokeCap.round,
            ),
          ),
          ?child,
        ],
      ),
    );
  }
}
