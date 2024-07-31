import 'package:flutter/material.dart';

class BankLoadingWidget extends StatefulWidget {
  const BankLoadingWidget({super.key});

  @override
  State<BankLoadingWidget> createState() => _BankLoadingWidgetState();
}

class _BankLoadingWidgetState extends State<BankLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      child: FadeTransition(
        opacity: _animation,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  height: 30.0,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  height: 30.0,
                ),
              ],
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5.0),
              ),
              height: 50.0,
              width: 50.0,
            ),
            const SizedBox(
              width: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
