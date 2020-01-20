import 'package:appunite_clock/common/colors.dart';
import 'package:flutter/material.dart';

class DateText extends StatelessWidget {
  final String day;
  final String date;

  const DateText({
    Key key,
    @required this.day,
    @required this.date,
  })  : assert(day != null),
        assert(date != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          day,
          style: TextStyle(
            color: MainColors.lightOrDark(context, MainColors.lightDayText, MainColors.darkDayText),
            fontSize: 24,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          date,
          style: TextStyle(
            color: MainColors.lightOrDark(context, MainColors.lightDateText, MainColors.darkDateText),
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final String text;
  final Icon icon;

  const TextWithIcon({
    Key key,
    @required this.text,
    @required this.icon,
  })  : assert(text != null),
        assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        icon,
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: MainColors.additionalInfoText,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}

class AnimatedText extends StatefulWidget {
  final String text;

  const AnimatedText({
    Key key,
    @required this.text,
  }) : super(key: key);

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  String oldText = "";

  @override
  void initState() {
    super.initState();

    oldText = widget.text;
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(AnimatedText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      oldText = oldWidget.text;
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final value = _animationController.value;
        return Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Align(
              alignment: Alignment(0, -value),
              child: Opacity(
                opacity: 1 - value,
                child: Text(
                  oldText,
                  style: TextStyle(
                    color: MainColors.lightOrDark(context, MainColors.lightTimeText, MainColors.darkTimeText),
                    fontSize: 128,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 1 - value),
              child: Opacity(
                opacity: value,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: MainColors.lightOrDark(context, MainColors.lightTimeText, MainColors.darkTimeText),
                    fontSize: 128,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}
