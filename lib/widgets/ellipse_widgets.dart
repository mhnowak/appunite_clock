import 'package:appunite_clock/common/colors.dart';
import 'package:flutter/material.dart';

class MoonEllipse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Ellipse(
      color: MainColors.moon,
      child: Stack(
        children: <Widget>[
          const Align(
            alignment: Alignment(-0.15, -0.8),
            child: const _MoonCircle(size: 10),
          ),
          const Align(
            alignment: Alignment(-0.75, 0.1),
            child: const _MoonCircle(size: 18),
          ),
          const Align(
            alignment: Alignment(-0.2, 0.6),
            child: const _MoonCircle(size: 9),
          ),
          const Align(
            alignment: Alignment(0.85, 0),
            child: const _MoonCircle(size: 5),
          ),
          const Align(
            alignment: Alignment(0.4, 0.65),
            child: const _MoonCircle(size: 13),
          ),
          const Align(
            alignment: Alignment(0.1, -0.3),
            child: const _MoonCircle(size: 25),
          ),
        ],
      ),
    );
  }
}

class SunEllipse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Ellipse(
      color: MainColors.sun,
    );
  }
}

class _Ellipse extends StatelessWidget {
  final Color color;
  final double size;
  final Widget child;

  const _Ellipse({Key key, @required this.color, this.size = 240, this.child = const SizedBox.shrink()})
      : assert(color != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(size / 2);

    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: borderRadius,
      ),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: borderRadius,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color.withOpacity(0.25),
            borderRadius: borderRadius,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: color.withOpacity(1),
              borderRadius: borderRadius,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _MoonCircle extends StatelessWidget {
  final double size;

  const _MoonCircle({Key key, @required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(colors: [MainColors.moonGradientColor, Colors.white], end: Alignment(0.8, -0.8)),
      ),
    );
  }
}