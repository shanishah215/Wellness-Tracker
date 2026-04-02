import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Extensions for handling responsive layout logic and screen measurements.
extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isNeoMobile => ResponsiveBreakpoints.of(this).isMobile;
  bool get isNeoTablet => ResponsiveBreakpoints.of(this).isTablet;
  bool get isNeoDesktop => ResponsiveBreakpoints.of(this).isDesktop;

  /// Returns a responsive padding value based on the current screen size.
  double get responsivePadding => ResponsiveValue<double>(
        this,
        defaultValue: 16.0,
        conditionalValues: [
          const Condition.largerThan(name: MOBILE, value: 24.0),
          const Condition.largerThan(name: TABLET, value: 32.0),
          const Condition.largerThan(name: DESKTOP, value: 48.0),
        ],
      ).value;

  /// Returns the optimal grid cross-axis count for the current screen size.
  double get gridCrossAxisCount {
    if (isNeoMobile) return 2;
    if (isNeoTablet) return 2; // Switched to 2 for better alignment of 4 cards
    if (isNeoDesktop) return 4;
    return 4;
  }

  /// Calculates a scaling factor to adjust font sizes and dimensions across devices.
  double get scale {
    if (isNeoMobile) return (screenWidth / 375).clamp(0.85, 1.3);
    if (isNeoTablet) return (screenWidth / 768).clamp(0.85, 1.25);
    return 1.0;
  }

  /// Scales a flat [size] value using the calculated [scale] factor.
  double scaled(double size) => (size * scale).clamp(size * 0.85, size * 1.5);
}

/// Utility extensions for numbers to create sized boxes for spacing.
extension SpacingExtension on num {
  SizedBox get vSpace => SizedBox(height: toDouble());
  SizedBox get hSpace => SizedBox(width: toDouble());
}

/// Utility extensions for colors to generate variations.
extension ColorExtension on Color {
  /// Returns a darkened version of the color.
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  /// Returns a lightened version of the color.
  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}
