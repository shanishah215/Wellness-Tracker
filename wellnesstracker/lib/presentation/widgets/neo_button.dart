import 'package:flutter/material.dart';
import '../../core/utils/neomorphic_utility.dart';

/// A Neomorphic button that provides visual feedback when pressed.
class NeoButton extends StatefulWidget {
  /// The widget to display inside the button.
  final Widget child;

  /// The callback to execute when the button is pressed.
  final VoidCallback onPressed;

  /// The radius of the button's corners. Defaults to 15.
  final double borderRadius;

  /// The padding around the child. Defaults to vertical 12, horizontal 24.
  final EdgeInsetsGeometry padding;

  const NeoButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius = 15,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  });

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() => _isPressed = true);
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() => _isPressed = false);
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: _isPressed
              ? [] 
              : NeoUtils.outerShadow(context: context),
          gradient: NeoUtils.neoGradient(context: context, isPressed: _isPressed),
        ),
        child: widget.child,
      ),
    );
  }
}
