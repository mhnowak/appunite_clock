import 'package:appunite_clock/bloc/clock_bloc.dart';
import 'package:appunite_clock/common/colors.dart';
import 'package:appunite_clock/common/util.dart';
import 'package:appunite_clock/model/weather_helpers.dart';
import 'package:appunite_clock/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ClockCard extends StatelessWidget {
  const ClockCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = MainColors.lightOrDark(
      context,
      MainColors.lightCardBackground,
      MainColors.darkCardBackground,
    );

    final bloc = Provider.of<ClockBloc>(context);

    return Container(
      width: 777,
      height: 411,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Expanded(child: const TimeWrapper()),
          Divider(
            indent: 64,
            endIndent: 64,
            color: MainColors.lightOrDark(context, MainColors.lightDivider, MainColors.darkDivider),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<String>(
                  stream: bloc.locationStream,
                  initialData: "",
                  builder: (context, snapshot) {
                    return TextWithIcon(
                      text: snapshot.data,
                      icon: Icon(Icons.location_city, color: MainColors.darkDayText),
                    );
                  }),
              const SizedBox(width: 16),
              StreamBuilder<WeatherWithTemperatureHolder>(
                stream: bloc.weatherInfoStream,
                initialData: WeatherWithTemperatureHolder(WeatherCondition.sunny, ""),
                builder: (context, snapshot) {
                  final data = snapshot.data;

                  final weatherToString = data.condition.toString().split('.').last;
                  final weatherUpperCased =
                      weatherToString.substring(0, 1).toUpperCase() + weatherToString.substring(1);

                  final text = "$weatherUpperCased, ${data.temperature}";
                  final icon = WeatherConditionUtil.getWeatherIcon(data.condition);
                  return TextWithIcon(
                    text: text,
                    icon: icon,
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class TimeWrapper extends StatefulWidget {
  const TimeWrapper();

  @override
  _TimeWrapperState createState() => _TimeWrapperState();
}

class _TimeWrapperState extends State<TimeWrapper> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ClockBloc>(context);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: bloc.currentTimeEach10HoursStream,
              initialData: DateTime.now(),
              builder: (context, snapshot) {
                return AnimatedText(
                  text: DateFormat.Hm().format(snapshot.data).split(":").first[0],
                );
              },
            ),
            StreamBuilder(
              stream: bloc.currentTimeEachHourStream,
              initialData: DateTime.now(),
              builder: (context, snapshot) {
                return AnimatedText(
                  text: DateFormat.Hm().format(snapshot.data).split(":").first[1],
                );
              },
            ),
            Text(
              ":",
              style: TextStyle(
                fontSize: 128,
                color: MainColors.lightOrDark(context, MainColors.colon, MainColors.darkTimeText.withOpacity(0.6)),
              ),
            ),
            StreamBuilder(
              stream: bloc.currentTimeEach10MinutesStream,
              initialData: DateTime.now(),
              builder: (context, snapshot) {
                return AnimatedText(
                  text: DateFormat.Hm().format(snapshot.data).split(":").last[0],
                );
              },
            ),
            StreamBuilder(
              stream: bloc.currentTimeEachMinuteStream,
              initialData: DateTime.now(),
              builder: (context, snapshot) {
                return AnimatedText(
                  text: DateFormat.Hm().format(snapshot.data).split(":").last[1],
                );
              },
            ),
          ],
        ),
        Align(
          alignment: Alignment(0, 0.64),
          child: StreamBuilder(
            stream: bloc.currentDayStream,
            initialData: DateTime.now(),
            builder: (context, snapshot) {
              final data = snapshot.data;
              return DateText(day: DateFormat.EEEE().format(data), date: DateFormat.yMMMd().format(data));
            },
          ),
        ),
      ],
    );
  }
}
