import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'dark_mode_switcher_state.dart';

class DarkModeSwitcherController extends ChangeNotifier {
  static const int durationDefault = 250; //Default animation duration (milisec)
  static const double valueStart = 0.0; //Default start value
  static const double valueEnd = 1.0; //Default end value

  final AnimationController controller;
  Animation colorTween;

  DarkModeSwitcherState state = DarkModeSwitcherState.sun;
  DarkModeSwitcherState prevState = DarkModeSwitcherState.sun;

  double get progress => controller.value;
  Color get background => colorTween.value;

  DarkModeSwitcherController(Color start, Color end,
      {@required TickerProvider vsync, this.state})
      : controller = AnimationController(vsync: vsync) {
    controller.addListener(_onStateUpdate);
    colorTween = ColorTween(begin: start, end: end).animate(controller);
    prevState = state;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onStateUpdate() {
    notifyListeners();
  }

  void _startAnimation(double animationTo) {
    controller
      ..duration = const Duration(milliseconds: durationDefault)
      ..animateTo(animationTo);
    notifyListeners();
  }

  void setSunState() {
    _startAnimation(valueStart);
    state = DarkModeSwitcherState.sun;
  }

  void setMoonState() {
    _startAnimation(valueEnd);
    state = DarkModeSwitcherState.moon;
  }
}
