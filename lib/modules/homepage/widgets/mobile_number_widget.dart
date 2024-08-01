import 'package:flutter/material.dart';

class MobileNumberWidget extends StatelessWidget {
  const MobileNumberWidget({
    super.key,
    required this.index,
    required List<String> phoneNumbers,
  }) : _phoneNumbers = phoneNumbers;

  final int index;
  final List<String> _phoneNumbers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(2),
              topRight: Radius.circular(2),
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(2.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.call_outlined,
                color: Theme.of(context).primaryColor,
                size: 14.0,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "$index",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        Text(
          _phoneNumbers[index],
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
