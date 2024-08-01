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
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Add a new mobile number",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "This number will be used for fetching accounts.",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const Text(
                              "Enter mobile number",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '',
                                hintText: '10 digit indian mobile number',
                              ),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                  minimumSize: WidgetStatePropertyAll<Size>(
                                Size(double.infinity, 50.0),
                              )),
                              child: const Text("Verify number with OTP"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
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
