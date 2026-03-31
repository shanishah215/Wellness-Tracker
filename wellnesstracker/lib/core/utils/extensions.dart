import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

extension ResponsiveExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isNeoMobile => ResponsiveBreakpoints.of(this).isMobile;
  bool get isNeoTablet => ResponsiveBreakpoints.of(this).isTablet;
  bool get isNeoDesktop => ResponsiveBreakpoints.of(this).isDesktop;

  double get responsivePadding => ResponsiveValue<double>(
        this,
        defaultValue: 16.0,
        conditionalValues: [
          const Condition.largerThan(name: MOBILE, value: 24.0),
          const Condition.largerThan(name: TABLET, value: 32.0),
          const Condition.largerThan(name: DESKTOP, value: 48.0),
        ],
      ).value;

  double get gridCrossAxisCount {
    if (isNeoMobile) return 2;
    if (isNeoTablet) return 3;
    if (isNeoDesktop) return 4;
    return 6; // for 4K
  }

  double get scale {
    if (isNeoMobile) return (screenWidth / 375).clamp(0.85, 1.3); // Using 375 as base mobile width
    if (isNeoTablet) return (screenWidth / 768).clamp(0.85, 1.25); // Using 768 as base tablet width
    return 1.0;
  }

  double scaled(double size) => (size * scale).clamp(size * 0.85, size * 1.5);
}



extension SpacingExtension on num {
  SizedBox get vSpace => SizedBox(height: toDouble());
  SizedBox get hSpace => SizedBox(width: toDouble());
}

extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
    return hslLight.toColor();
  }
}
