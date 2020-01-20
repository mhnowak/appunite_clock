import 'package:appunite_clock/common/tuple2.dart';
import 'package:appunite_clock/model/weather_helpers.dart';
import 'package:rxdart/rxdart.dart';

class ClockBloc {
  Stream<WeatherWithTemperatureHolder> weatherInfoStream;
  Stream<String> locationStream;

  /// Stream used to simulate sun's or moon's position during the day
  Stream<Tuple2<Duration, Duration>> dayOrNightLengthBasedOnCurrentTimeWithCurrentProgressMade;

  /// All of the Streams provide DateTime.now() with only difference being frequency of the update
  Stream<DateTime> currentTimeEachMinuteStream;
  Stream<DateTime> currentTimeEach10MinutesStream;
  Stream<DateTime> currentTimeEachHourStream;
  Stream<DateTime> currentTimeEach10HoursStream;
  Stream<DateTime> currentDayStream;

  /// Based on this we use day-night mode
  Stream<bool> isDayTime;

  ClockBloc() {
    /// Some mocked data you can easily replace with real calls from the API etc.
    Stream<num> temperatureStream = Stream.value(27.4);
    Stream<TemperatureUnit> temperatureUnitStream = Stream.value(TemperatureUnit.celsius);
    Stream<String> temperatureStringStream = CombineLatestStream.combine2(temperatureStream, temperatureUnitStream,
        (num temperature, TemperatureUnit unit) => _temperatureString(temperature, unit));
    Stream<WeatherCondition> weatherConditionStream = Stream.value(WeatherCondition.windy);

    weatherInfoStream = CombineLatestStream.combine2(weatherConditionStream, temperatureStringStream,
            (condition, temperatureString) => WeatherWithTemperatureHolder(condition, temperatureString))
        .asBroadcastStream();
    locationStream = Stream.value("Poznań, Greater Poland").asBroadcastStream();

    /// Sunrise Sunset Moonset dates - this is used to simulate sun moving during the day and the moon during the night
    /// Please make sure not to set sunrise before sunset and moonset before sunset since it might cause to some
    /// unexpected behavior of the sun movement or even potential crashes.
    final dateNow = DateTime.now();
    final DateTime sunrise = DateTime(dateNow.year, dateNow.month, dateNow.day, 14, 21);
    final DateTime sunset = DateTime(dateNow.year, dateNow.month, dateNow.day, 20, 00);
    final DateTime moonset = DateTime(dateNow.year, dateNow.month, dateNow.day, 21, 00);

    Stream<DateTime> currentTimeStream = Stream.periodic(Duration(seconds: 1), (_) => DateTime.now()).share();

    isDayTime = currentTimeStream.map((DateTime time) => time.isBefore(sunset)).distinctUnique().share();

    dayOrNightLengthBasedOnCurrentTimeWithCurrentProgressMade = isDayTime.map((isDay) => isDay
        ? Tuple2(sunset.difference(sunrise), DateTime.now().difference(sunrise))
        : Tuple2(moonset.difference(sunset), DateTime.now().difference(sunset)));

    currentDayStream = currentTimeStream.distinct((curr, next) => curr.day == next.day);
    currentTimeEachMinuteStream = currentTimeStream.distinct((curr, next) => curr.second == next.second);
    currentTimeEach10MinutesStream =
        currentTimeStream.distinct((curr, next) => (curr.second ~/ 10) == (next.second ~/ 10));
    currentTimeEachHourStream = currentTimeStream.distinct((curr, next) => curr.minute == next.minute);
    currentTimeEach10HoursStream =
        currentTimeStream.distinct((curr, next) => (curr.minute ~/ 10) == (next.minute ~/ 10));
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
