import 'package:flutter/material.dart';

import '../widgets/mobile_number_widget.dart';

class MobileNumberManagementView extends StatefulWidget {
  const MobileNumberManagementView({
    super.key,
    required List<String> phoneNumbers,
  }) : _phoneNumbers = phoneNumbers;

  final List<String> _phoneNumbers;

  @override
  State<MobileNumberManagementView> createState() =>
      _MobileNumberManagementViewState();
}

class _MobileNumberManagementViewState
    extends State<MobileNumberManagementView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Your mobile numbers",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all<Color>(
                    Colors.blueAccent,
                  ),
                ),
                label: const Text("Add"),
                icon: const Icon(
                  Icons.add,
                  size: 24,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Wrap(
            spacing: 50.0,
            runSpacing: 20.0,
            children: List.generate(
              widget._phoneNumbers.length,
              (index) {
                return MobileNumberWidget(
                  index: index,
                  phoneNumbers: widget._phoneNumbers,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
