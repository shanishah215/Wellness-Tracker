import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/extensions.dart';
import '../widgets/neo_card.dart';
import '../widgets/neo_progress_bar.dart';
import '../widgets/neo_button.dart';
import '../widgets/neo_background.dart';

/// Screen displaying detailed information for a specific wellness activity.
class ActivityDetailScreen extends StatelessWidget {
  /// The title of the activity (e.g., "Steps", "Water").
  final String title;

  /// Progress value between 0.0 and 1.0.
  final double progress;

  /// The formatted text value to display (e.g., "7,540", "2.1L").
  final String value;

  /// The theme color associated with this activity.
  final Color color;

  /// Optional icon to represent the activity.
  final IconData? icon;

  const ActivityDetailScreen({
    super.key,
    required this.title,
    required this.progress,
    required this.value,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          title.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: context.scaled(18),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: NeoBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.responsivePadding).copyWith(top: kToolbarHeight + 40),
          child: Column(
            children: [
              // Today's Progress Card with animation
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double val, child) {
                  return FractionalTranslation(
                    translation: Offset(0, 0.1 * (1 - val)),
                    child: Opacity(opacity: val, child: child),
                  );
                },
                child: NeoCard(
                  isGlass: true,
                  padding: EdgeInsets.all(context.scaled(24)),
                  child: Column(
                    children: [
                      Text(
                        "TODAY'S PROGRESS",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.grey.shade600,
                          letterSpacing: 1.2,
                          fontSize: context.scaled(12),
                        ),
                      ),
                      32.vSpace,
                      NeoCircularProgress(
                        progress: progress,
                        size: context.scaled(200),
                        color: color,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon ?? Icons.directions_run, color: color.withValues(alpha: 0.8), size: context.scaled(32)),
                            8.vSpace,
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: context.scaled(32), fontWeight: FontWeight.bold, color: color),
                              ),
                            ),
                            Text(
                              title,
                              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      32.vSpace,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: color.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.lightbulb_outline, color: color, size: 20),
                            12.hSpace,
                            Expanded(
                              child: Text(
                                "You've reached ${(progress * 100).toStringAsFixed(0)}% of your daily goal. Keep it up!",
                                style: TextStyle(fontSize: context.scaled(12), color: textTheme.bodyMedium?.color),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              24.vSpace,
              // Recent History section with animation
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                tween: Tween<double>(begin: 0, end: 1),
                builder: (context, double val, child) {
                  return Opacity(
                    opacity: val,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - val)),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "RECENT HISTORY",
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: context.scaled(12), letterSpacing: 1.2),
                      ),
                    ),
                    16.vSpace,
                    ...List.generate(5, (index) => _buildHistoryItem(context, index)),
                  ],
                ),
              ),
              32.vSpace,
              NeoButton(
                onPressed: () => Get.back(),
                child: Center(
                  child: Text(
                    "Back to Dashboard",
                    style: TextStyle(fontSize: context.scaled(16), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a single history list item with a mock date and value calculation.
  Widget _buildHistoryItem(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: NeoCard(
        isGlass: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.check_circle_outline, color: color, size: 18),
                ),
                16.hSpace,
                Text(
                  "March ${24 - index}",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: context.scaled(14)),
                ),
              ],
            ),
            Text(
              (double.parse(value.replaceAll(RegExp(r'[^0-9.]'), '')) * (1 - (index * 0.05))).toStringAsFixed(1),
              style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: context.scaled(16)),
            ),
          ],
        ),
      ),
    );
  }
}
