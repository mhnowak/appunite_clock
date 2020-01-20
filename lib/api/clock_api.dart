import 'package:appunite_clock/model/weather_helpers.dart';

abstract class ClockApi {
  Stream<num> getTemperatureStream();

  Stream<TemperatureUnit> getTemperatureUnitStream();

  Stream<WeatherCondition> getWeatherConditionStream();

  Stream<String> getLocationStream();

  /// Sunrise Sunset Moonset dates - this is used to simulate sun moving during the day and the moon during the night
  /// Please make sure not to set sunrise before sunset and moonset before sunset since it might cause to some
  /// unexpected behavior of the sun movement or even potential crashes.
  Stream<DateTime> getSunriseStream();

  Stream<DateTime> getSunsetStream();

  Stream<DateTime> getMoonsetStream();
}
