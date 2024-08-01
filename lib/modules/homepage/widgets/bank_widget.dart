import 'package:flutter/material.dart';

import '../../../utils/utility_functions.dart';

class BankWidget extends StatelessWidget {
  const BankWidget({
    super.key,
    required this.isSelected,
    required this.bank,
  });

final bool isSelected;
  final Map bank;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          // Simple box shadow
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          AbsorbPointer(
            absorbing: true,
            child: Checkbox(
              value: isSelected,
              visualDensity: VisualDensity.compact,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) {},
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bank['title'] as String,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "${bank['type']} account",
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                maskString(
                  bank['account_number'] as String,
                  "*",
                ),
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          const Spacer(),
          Image.network(
            bank['logo_url'] as String,
            height: 30.0,
            width: 30.0,
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
    );
  }
}
