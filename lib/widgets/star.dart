import 'package:appunite_clock/model/star_model.dart';
import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  final StarModel star;

  StarWidget({
    Key key,
    @required this.star,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: star.alignment,
      child: Container(
        width: star.size,
        height: star.size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}