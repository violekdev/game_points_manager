import 'package:flutter/material.dart';
class AnimatedCount extends ImplicitlyAnimatedWidget {
  final int prevCount;
  final int currCount;

  AnimatedCount(
      {Key key,
      @required this.prevCount,
      @required this.currCount,
      @required Duration duration,
      Curve curve = Curves.linear})
      : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedCountState();
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  IntTween _count;

  @override
  Widget build(BuildContext context) {
    return new Text(
      _count.evaluate(animation).toString(),
      style: TextStyle(fontSize: 20),
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _count = visitor(_count, widget.currCount,
        (dynamic value) => new IntTween(begin: value, end: widget.currCount));
  }
}