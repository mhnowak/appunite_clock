import 'package:appunite_clock/common/colors.dart';
import 'package:appunite_clock/icons/custom_icons_icons.dart';
import 'package:appunite_clock/model/star_model.dart';
import 'package:appunite_clock/widgets/star.dart';
import 'package:flutter/cupertino.dart';

class DayBackground extends StatelessWidget {
  const DayBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment(0.9, 1),
          child: Icon(
            CustomIcons.day_background,
            size: 440,
            color: MainColors.flower.withOpacity(0.04),
          ),
        ),
        Align(
          alignment: Alignment(-0.05, -1),
          child: Icon(
            CustomIcons.day_background_small,
            size: 170,
            color: MainColors.flower.withOpacity(0.04),
          ),
        ),
        Align(
          alignment: Alignment(-0.5, 1),
          child: Icon(
            CustomIcons.day_background_very_small,
            size: 110,
            color: MainColors.flower.withOpacity(0.04),
          ),
        ),
        Align(
          alignment: Alignment(-1, -0.3),
          child: Icon(
            CustomIcons.day_background_normal,
            size: 370,
            color: MainColors.flower.withOpacity(0.04),
          ),
        ),
      ],
    );
  }
}

class NightBackground extends StatelessWidget {
  const NightBackground();

  static final List<StarModel> starList = [
    StarModel(14, Alignment(0.2, 0.7)),
    StarModel(12, Alignment(0.85, -0.77)),
    StarModel(10, Alignment(-0.2, -0.65)),
    StarModel(8, Alignment(-0.7, -0.05)),
    StarModel(7, Alignment(-0.2, 0.72)),
    StarModel(7, Alignment(-0.9, 0.22)),
    StarModel(6, Alignment(0.66, -0.24)),
    StarModel(4, Alignment(0.47, 0.93)),
    StarModel(4, Alignment(-0.88, -0.23)),
    StarModel(4, Alignment(0.69, -0.67)),
    StarModel(3, Alignment(0.55, -0.78)),
    StarModel(3, Alignment(0, -0.87)),
    StarModel(12, Alignment(-0.9, -0.8)),
    StarModel(10, Alignment(0.88, 0.66)),
    StarModel(8, Alignment(0.1, 0.65)),
    StarModel(6, Alignment(-0.97, 0.8)),
    StarModel(2, Alignment(0.87, -0.11)),
    StarModel(10, Alignment(0.63, 0.79)),
    StarModel(6, Alignment(0.73, 0.33)),
    StarModel(12, Alignment(-0.67, 0.68)),
    StarModel(10, Alignment(0.23, -0.77)),
    StarModel(8, Alignment(0.89, 0.1)),
    StarModel(4, Alignment(0, 0.79)),
    StarModel(5, Alignment(-0.41, -0.87)),
    StarModel(4, Alignment(-0.67, -0.48)),
    StarModel(5, Alignment(0.33, -0.92)),
    StarModel(6, Alignment(-0.5, 0.98)),
    StarModel(6, Alignment(-0.5, -0.66)),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: starList.map((StarModel star) => StarWidget(star: star)).toList(),
    );
  }
}
