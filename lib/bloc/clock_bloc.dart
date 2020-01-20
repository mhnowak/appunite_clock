import 'package:appunite_clock/api/clock_api.dart';
import 'package:appunite_clock/common/tuple2.dart';
import 'package:appunite_clock/common/util.dart';
import 'package:appunite_clock/model/weather_helpers.dart';
import 'package:rxdart/rxdart.dart';

class ClockBloc {
  Stream<WeatherWithTemperatureHolder> weatherInfoStream;
  Stream<String> locationStream;

  /// Stream used to simulate sun's or moon's position during the day
  ///
  /// [first] is the total animation length,
  /// [last] is the current position of the animation,
  Stream<Tuple2<Duration, Duration>> ellipseAnimationDurationsStream;

  /// All of the Streams provide DateTime.now() with only difference being frequency of the update
  Stream<DateTime> currentTimeEachMinuteStream;
  Stream<DateTime> currentTimeEach10MinutesStream;
  Stream<DateTime> currentTimeEachHourStream;
  Stream<DateTime> currentTimeEach10HoursStream;
  Stream<DateTime> currentDayStream;

  /// Based on this we use day-night mode
  Stream<bool> isDayTime;

  ClockBloc(final ClockApi api) {
    Stream<String> temperatureStringStream = CombineLatestStream.combine2(
        api.getTemperatureStream(),
        api.getTemperatureUnitStream(),
        (num temperature, TemperatureUnit unit) => TemperatureUtil.temperatureString(temperature, unit));

    weatherInfoStream = CombineLatestStream.combine2(api.getWeatherConditionStream(), temperatureStringStream,
            (condition, temperatureString) => WeatherWithTemperatureHolder(condition, temperatureString))
        .asBroadcastStream();
    locationStream = Stream.value("Poznań, Greater Poland").asBroadcastStream();

    final Stream<DateTime> sunriseStream = api.getSunriseStream().shareReplay();
    final Stream<DateTime> sunsetStream = api.getSunsetStream().shareReplay();
    final Stream<DateTime> moonsetStream = api.getMoonsetStream().share();

    Stream<DateTime> currentTimeStream = Stream.periodic(Duration(seconds: 1), (_) => DateTime.now()).share();

    isDayTime = CombineLatestStream.combine3(
      currentTimeStream,
      sunriseStream,
      sunsetStream,
      (DateTime time, DateTime sunrise, DateTime sunset) => time.isAfter(sunrise) && time.isBefore(sunset),
    ).distinctUnique().share();

    ellipseAnimationDurationsStream = isDayTime.switchMap((isDay) => isDay
        ? CombineLatestStream.combine2(
            sunriseStream,
            sunsetStream,
            (DateTime sunrise, DateTime sunset) =>
                Tuple2(sunset.difference(sunrise), DateTime.now().difference(sunrise)))
        : CombineLatestStream.combine2(
            sunsetStream,
            moonsetStream,
            (DateTime sunset, DateTime moonset) =>
                Tuple2(moonset.difference(sunset), DateTime.now().difference(sunset))));

    currentDayStream = currentTimeStream.distinct((curr, next) => curr.day == next.day);
    currentTimeEachMinuteStream = currentTimeStream.distinct((curr, next) => curr.minute == next.minute);
    currentTimeEach10MinutesStream =
        currentTimeStream.distinct((curr, next) => (curr.minute ~/ 10) == (next.minute ~/ 10));
    currentTimeEachHourStream = currentTimeStream.distinct((curr, next) => curr.hour == next.hour);
    currentTimeEach10HoursStream =
        currentTimeStream.distinct((curr, next) => (curr.hour ~/ 10) == (next.hour ~/ 10));
  }
}
