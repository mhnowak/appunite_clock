import 'package:appunite_clock/common/util.dart';
import 'package:appunite_clock/widgets/ellipse_widgets.dart';
import 'package:flutter/material.dart';

class EllipseAnimation extends AnimatedWidget {
  const EllipseAnimation({
    Key key,
    @required Animation<double> animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;
    return Align(
      alignment: EllipsePositionUtils.getPosition(animation.value),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Visibility(
          visible: Theme.of(context).brightness == Brightness.light,
          child: SunEllipse(),
          replacement: MoonEllipse(),
        ),
      ),
    );
  }
}
