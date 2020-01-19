import 'dart:async';

import 'package:appunite_clock/bloc/clock_bloc.dart';
import 'package:appunite_clock/widgets/backgrounds.dart';
import 'package:appunite_clock/widgets/clock_card.dart';
import 'package:appunite_clock/widgets/ellipse_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppUniteClock extends StatefulWidget {
  const AppUniteClock({
    Key key,
  }) : super(key: key);

  @override
  _AppUniteClockState createState() => _AppUniteClockState();
}

class _AppUniteClockState extends State<AppUniteClock> with SingleTickerProviderStateMixin {
  AnimationController _ellipseAnimation;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _ellipseAnimation = AnimationController(
      duration: Duration(days: 1),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _subscription = Provider.of<ClockBloc>(context).dayOrNightLengthBasedOnCurrentTimeWithCurrentProgressMade.listen((lengthAndDifference) {
      _ellipseAnimation.duration = lengthAndDifference.first;
      _ellipseAnimation.forward(from: lengthAndDifference.second.inSeconds / lengthAndDifference.first.inSeconds);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _ellipseAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Visibility(
          visible: Theme.of(context).brightness == Brightness.dark,
          child: const NightBackground(),
          replacement: const DayBackground(),
        ),
        const ClockCard(),
        EllipseAnimation(animation: _ellipseAnimation),
      ],
    );
  }
}