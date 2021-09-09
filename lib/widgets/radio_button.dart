import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String value;
  final String groupValue;
  final void Function(String? value)? onChanged;

  const RadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        InkWell(
          onTap: () {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          child: Text(value),
        ),
      ],
    );
  }
}
