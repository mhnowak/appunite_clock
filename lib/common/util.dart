import 'dart:math';

import 'package:appunite_clock/bloc/clock_bloc.dart';
import 'package:appunite_clock/common/colors.dart';
import 'package:appunite_clock/model/weather_helpers.dart';
import 'package:appunite_clock/widgets/star.dart';
import 'package:flutter/material.dart';

class TemperatureUtil {
  /// Temperature with unit of measurement.
  static String temperatureString(num temperature, TemperatureUnit unit) {
    return '${temperature.toStringAsFixed(1)}${_unitString(unit)}';
  }

  /// Temperature unit of measurement with degrees.
  static String _unitString(TemperatureUnit unit) {
    switch (unit) {
      case TemperatureUnit.fahrenheit:
        return '°F';
      case TemperatureUnit.celsius:
      default:
        return '°C';
    }
  }
}

class EllipsePositionUtils {
  /// Between -1.5,0 -> 1.5,0 and -1.5,0 -> 0, -1.5
  ///
  /// for 0.0 = -1.5,0
  /// for 0.1 = -1.2,-0.3
  /// for 0.5 = 0,-1.5
  /// for 0.9 = 1.2,-0.3
  /// for 1.0 = 1.5, 0
  static Alignment getPosition(double basedOnProgress) {
    final x = basedOnProgress * 3 - 1.5;
    final y = -sin(basedOnProgress * pi) * 1.5;
    return Alignment(x, y);
  }
}

class WeatherConditionUtil {
  static Icon getWeatherIcon(WeatherCondition condition) {
    switch(condition) {
      case WeatherCondition.cloudy:
        return Icon(Icons.wb_cloudy, color: MainColors.darkDayText);
      case WeatherCondition.foggy:
        return Icon(Icons.grain, color: MainColors.darkDayText);
      case WeatherCondition.rainy:
        return Icon(Icons.cloud_queue, color: MainColors.darkDayText);
      case WeatherCondition.snowy:
        return Icon(Icons.ac_unit, color: Colors.white);
      case WeatherCondition.sunny:
        return Icon(Icons.wb_sunny, color: MainColors.sunSmall);
      case WeatherCondition.thunderstorm:
        return Icon(Icons.flash_on, color: MainColors.sunSmall);
      case WeatherCondition.windy:
        return Icon(Icons.trending_flat, color: MainColors.darkDayText);
      default:
        return Icon(Icons.wb_sunny, color: MainColors.sunSmall);
    }
  }
}
