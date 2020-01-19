class WeatherWithTemperatureHolder {
  final WeatherCondition condition;
  final String temperature;

  const WeatherWithTemperatureHolder(this.condition, this.temperature);
}

/// Weather condition in English.
enum WeatherCondition {
  cloudy,
  foggy,
  rainy,
  snowy,
  sunny,
  thunderstorm,
  windy,
}

/// Temperature unit of measurement.
enum TemperatureUnit {
  celsius,
  fahrenheit,
}