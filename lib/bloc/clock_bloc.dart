import 'package:appunite_clock/common/tuple2.dart';
import 'package:appunite_clock/model/weather_helpers.dart';
import 'package:rxdart/rxdart.dart';

class ClockBloc {
  Stream<WeatherWithTemperatureHolder> weatherInfoStream;
  Stream<String> locationStream;

  Stream<Tuple2<Duration, Duration>> dayOrNightLengthBasedOnCurrentTimeWithCurrentProgressMade;

  Stream<DateTime> currentTimeEachMinuteStream;
  Stream<DateTime> currentTimeEach10MinutesStream;
  Stream<DateTime> currentTimeEachHourStream;
  Stream<DateTime> currentTimeEach10HoursStream;

  /// Emits only while day changes
  Stream<DateTime> currentDayStream;

  Stream<bool> isDayTime;

  ClockBloc() {
    /// Some mocked data you can easily replace with real calls from the API etc.
    Stream<num> temperatureStream = Stream.value(27.4);
    Stream<TemperatureUnit> temperatureUnitStream = Stream.value(TemperatureUnit.celsius);
    Stream<String> temperatureStringStream = CombineLatestStream.combine2(temperatureStream, temperatureUnitStream,
        (num temperature, TemperatureUnit unit) => _temperatureString(temperature, unit));
    Stream<WeatherCondition> weatherConditionStream = Stream.value(WeatherCondition.windy);

    weatherInfoStream = CombineLatestStream.combine2(weatherConditionStream, temperatureStringStream,
        (condition, temperatureString) => WeatherWithTemperatureHolder(condition, temperatureString)).asBroadcastStream();
    locationStream = Stream.value("Poznań, Greater Poland").asBroadcastStream();

    final dateNow = DateTime.now();
    Stream<DateTime> sunriseStream = Stream.value(DateTime(dateNow.year, dateNow.month, dateNow.day, 7, 21)).share();
    Stream<DateTime> sunsetStream = Stream.value(DateTime(dateNow.year, dateNow.month, dateNow.day, 17, 40)).share();
    Stream<DateTime> moonsetStream =
        Stream.value(DateTime(dateNow.year, dateNow.month, dateNow.day + 1, 5, 21)).share();

    Stream<Duration> dayLengthStream =
        CombineLatestStream.combine2(sunriseStream, sunsetStream, (DateTime sunrise, DateTime sunset) {
      return sunrise.difference(sunset);
    }).share();
    Stream<Duration> nightLengthStream =
        CombineLatestStream.combine2(sunsetStream, moonsetStream, (DateTime sunset, DateTime moonset) {
      return sunset.difference(moonset);
    }).share();

    Stream<DateTime> currentTimeStream = Stream.periodic(Duration(seconds: 1), (_) => DateTime.now()).share();

    isDayTime = CombineLatestStream.combine2(
            currentTimeStream, sunsetStream, (DateTime time, DateTime sunset) => time.isBefore(sunset))
        .distinctUnique()
        .share();

    dayOrNightLengthBasedOnCurrentTimeWithCurrentProgressMade =
        Stream.value(Tuple2(Duration(hours: 6), Duration(hours: 4))).asBroadcastStream();
    // TODO: With this part of code I need some help. I'm stuck here.
//        isDayTime.switchMap((isDay) => isDay
//        ? CombineLatestStream.combine2(
//            dayLengthStream, sunriseStream, (length, sunrise) {
//              print(length);
//              print(sunrise);
//              return Tuple2(length, DateTime.now().difference(sunrise));
//            })
//        : CombineLatestStream.combine2(
//            nightLengthStream, sunsetStream, (length, sunset) => Tuple2(length, DateTime.now().difference(sunset))));

    currentDayStream = currentTimeStream.distinct((curr, next) => curr.day == next.day);
    currentTimeEachMinuteStream = currentTimeStream.distinct((curr, next) => curr.minute == next.minute);
    currentTimeEach10MinutesStream = currentTimeStream.distinct((curr, next) => (curr.minute ~/ 10) == (next.minute ~/ 10));
    currentTimeEachHourStream = currentTimeStream.distinct((curr, next) => curr.hour == next.hour);
    currentTimeEach10HoursStream = currentTimeStream.distinct((curr, next) => (curr.hour ~/ 10) == (next.hour ~/ 10));
  }

  /// Temperature with unit of measurement.
  String _temperatureString(num temperature, TemperatureUnit unit) {
    return '${temperature.toStringAsFixed(1)}${_unitString(unit)}';
  }

  /// Temperature unit of measurement with degrees.
  String _unitString(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.fahrenheit:
        return '°F';
      case TemperatureUnit.celsius:
      default:
        return '°C';
    }
  }
}
