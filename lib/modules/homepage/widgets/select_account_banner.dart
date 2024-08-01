import 'package:flutter/material.dart';

class SelectAccountBanner extends StatelessWidget {
  const SelectAccountBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.secondary,
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: const Text(
        "Please select the account where your salary is credited",
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
