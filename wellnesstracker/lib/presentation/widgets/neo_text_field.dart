import 'package:flutter/material.dart';
import '../../core/utils/neomorphic_utility.dart';

/// A Neomorphic text input field that uses inner shadows for a recessed look.
class NeoTextField extends StatelessWidget {
  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Text that suggests what sort of input the field accepts.
  final String hintText;

  /// Optional icon to display before the text.
  final IconData? prefixIcon;

  /// Whether to hide the text being edited (e.g., for passwords).
  final bool obscureText;

  const NeoTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: NeoUtils.innerShadow(context: context),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
