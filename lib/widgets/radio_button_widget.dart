import 'package:flutter/material.dart';

class RadioButton<T> extends StatelessWidget {
  final T value;
  final String label;
  final T? groupValue;
  final void Function(T?)? onChanged;

  const RadioButton({
    super.key,
    required this.value,
    required this.label,
    this.groupValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => onChanged?.call(value),
      icon: Radio<T>(
        hoverColor: Colors.transparent,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
      label: Text(label),
    );
  }
}
