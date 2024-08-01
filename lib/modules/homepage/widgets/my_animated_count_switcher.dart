import 'package:flutter/material.dart';

class MyAnimatedSwitcher extends StatelessWidget {
  final int itemCount;

  const MyAnimatedSwitcher({
    super.key,
    required this.itemCount,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        // Define an opacity animation
        final opacityAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(animation);

        // Define a slide animation
        final slideAnimation = Tween<Offset>(
          begin: const Offset(0.0, -0.5),
          end: const Offset(0.0, 0.0),
        ).animate(animation);

        return SlideTransition(
          position: slideAnimation,
          child: FadeTransition(
            opacity: opacityAnimation,
            child: child,
          ),
        );
      },
      child: Text(
        "$itemCount",
        key: ValueKey<String>('$itemCount'),
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
