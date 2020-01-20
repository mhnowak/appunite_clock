import 'package:appunite_clock/api/mock_clock_api.dart';
import 'package:appunite_clock/bloc/clock_bloc.dart';
import 'package:appunite_clock/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'clock.dart';

void main() => runApp(AppUniteClockApp());

class AppUniteClockApp extends StatelessWidget {
  final ClockBloc bloc = ClockBloc(MockedClockApi());

  @override
  Widget build(BuildContext context) {
    // Disables top bar
    SystemChrome.setEnabledSystemUIOverlays([]);

    return StreamBuilder<bool>(
        stream: bloc.isDayTime,
        initialData: true,
        builder: (context, snapshot) {
          return MaterialApp(
            title: 'AppUnite Clock',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              brightness: snapshot.data ? Brightness.light : Brightness.dark,
              fontFamily: "Roboto",
            ),
            home: Provider.value(child: const ScaffoldOfClockWith5to3AspectRatio(), value: bloc),
          );
        });
  }
}

class ScaffoldOfClock extends StatelessWidget {
  const ScaffoldOfClock();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColors.lightOrDark(context, MainColors.lightBackground, MainColors.darkBackground),
      body: const Center(
        child: const AppUniteClock(),
      ),
    );
  }
}

class ScaffoldOfClockWith5to3AspectRatio extends StatelessWidget {
  const ScaffoldOfClockWith5to3AspectRatio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        /// Simulate 5:3 aspect ratio
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.width * 3) / 5,
          color: MainColors.lightOrDark(context, MainColors.lightBackground, MainColors.darkBackground),
          child: const AppUniteClock(),
        ),
      ),
    );
  }
}
