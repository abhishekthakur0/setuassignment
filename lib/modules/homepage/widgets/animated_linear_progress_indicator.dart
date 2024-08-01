import 'package:flutter/material.dart';

class AnimatedLinearProgressIndicator extends StatefulWidget {
  const AnimatedLinearProgressIndicator({
    Key? key,
    required this.value,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  final double value; // Target progress value (0.0 to 1.0)
  final Duration duration;

  @override
  _AnimatedLinearProgressIndicatorState createState() =>
      _AnimatedLinearProgressIndicatorState();
}

class _AnimatedLinearProgressIndicatorState
    extends State<AnimatedLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;
  late double _previousValue;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addListener(() {
        setState(() {}); // Update the widget during animation
      });

    _previousValue = 0.0;
    _animation = Tween<double>(begin: _previousValue, end: widget.value)
        .animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedLinearProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      _previousValue = _animation.value; // Save the current animation value
      _animation = Tween<double>(begin: _previousValue, end: widget.value)
          .animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ));
      _controller.duration = widget.duration;
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: _animation.value,
      minHeight: 6.0,
      color: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      semanticsLabel: "Loading progress",
    );
  }
}
