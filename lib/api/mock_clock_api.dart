import 'package:appunite_clock/api/clock_api.dart';
import 'package:appunite_clock/model/weather_helpers.dart';

class MockedClockApi extends ClockApi {
  final _dateNow = DateTime.now();

  @override
  Stream<String> getLocationStream() => Stream.value("Poznań, Greater Poland");

  @override
  Stream<DateTime> getMoonsetStream() => Stream.value(DateTime(_dateNow.year, _dateNow.month, _dateNow.day + 1, 2, 50));

  @override
  Stream<DateTime> getSunriseStream() => Stream.value(DateTime(_dateNow.year, _dateNow.month, _dateNow.day, 4, 21));

  @override
  Stream<DateTime> getSunsetStream() => Stream.value(DateTime(_dateNow.year, _dateNow.month, _dateNow.day, 16, 00));

  @override
  Stream<num> getTemperatureStream() => Stream.value(27.04);

  @override
  Stream<TemperatureUnit> getTemperatureUnitStream() => Stream.value(TemperatureUnit.celsius);

  @override
  Stream<WeatherCondition> getWeatherConditionStream() => Stream.value(WeatherCondition.windy);
}