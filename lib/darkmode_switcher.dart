library darkmode_switcher;

import 'package:flutter/material.dart';
import 'dark_mode_switcher_controler.dart';
import 'dark_mode_switcher_state.dart';
import 'dark_mode_switcher_painter.dart';

typedef ValueChanged = Function(DarkModeSwitcherState state);

class DarkModeSwitcher extends StatefulWidget {
  static const double widthDefault = 60; //Default width for switcher
  static const double heightDefault = 30; //Default height for switcher
  static const DarkModeSwitcherState stateDefault =
      DarkModeSwitcherState.sun; //Default state for switcher
  static const double heightToRadiusRatioDefault = 0.70;
  static const Color sunColorDefault = Color.fromARGB(255, 247, 195, 68);
  static const Color backgroundSunDefault = Color.fromARGB(255, 37, 25, 56);
  static const Color backgroundMoonDefault = Color.fromARGB(255, 224, 224, 224);

  final double width;
  final double height;
  final double heightToRadiusRatio;
  final Color sunColor;
  final DarkModeSwitcherState state;
  final Color backgroundSun;
  final Color backgroundMoon;
  final ValueChanged valueChanged;

  DarkModeSwitcher(
      {@required this.valueChanged,
      this.state = stateDefault,
      this.width = widthDefault,
      this.height = heightDefault,
      this.sunColor = sunColorDefault,
      this.backgroundSun = backgroundSunDefault,
      this.backgroundMoon = backgroundMoonDefault,
      this.heightToRadiusRatio = heightToRadiusRatioDefault}) {
    assert(_colorIsValid(sunColor));
    assert(_colorIsValid(backgroundSun));
    assert(_colorIsValid(backgroundMoon));
    assert(_heightToRadiusIsValid(heightToRadiusRatio));
    assert(_sizeIsValid(width, height));
  }

  @override
  _DarkModeSwitcherState createState() => _DarkModeSwitcherState();

  bool _sizeIsValid(double width, double height) {
    assert(width != null, 'Width argument was null.');
    assert(height != null, 'Height argument was null.');
    assert(width > height,
        'Width argument should be greater than height argument.');
    return true;
  }

  bool _colorIsValid(Color color) {
    assert(color != null, 'Color argument was null.');
    return true;
  }

  bool _heightToRadiusIsValid(double heightToRadius) {
    assert(heightToRadius != null, 'Height to radius argument was null.');
    assert(heightToRadius > 0 && heightToRadius < 1,
        'Height to radius argument Must be in the range 0 to 1');
    return true;
  }
}

class _DarkModeSwitcherState extends State<DarkModeSwitcher>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  DarkModeSwitcherController _slideController;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _slideController = DarkModeSwitcherController(
        widget.backgroundMoon, widget.backgroundSun,
        vsync: this, state: widget.state)
      ..addListener(() => setState(() {}));
    _setSwitcherState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: GestureDetector(
        onTap: () {
          _updateSwitcherState();
          widget.valueChanged(_slideController.state);
        },
        onHorizontalDragUpdate: _updateStateOnHorizontalDrag,
        child: Container(
          height: widget.height,
          width: widget.width,
          child: CustomPaint(
            painter: SwitchPainter(_slideController.progress,
                backgroundColor: _slideController.background,
                sunColor: widget.sunColor,
                heightToRadiusRatio: widget.heightToRadiusRatio),
          ),
        ),
      ),
    );
  }

  void _updateSwitcherState() {
    if (_slideController.state == DarkModeSwitcherState.sun) {
      _slideController.setMoonState();
    } else {
      _slideController.setSunState();
    }
    setState(() {});
    _slideController.prevState = _slideController.state;
  }

  void _setSwitcherState() {
    if (_slideController.state == DarkModeSwitcherState.moon) {
      _slideController.setMoonState();
    } else {
      _slideController.setSunState();
    }
    setState(() {});
  }

  void _updateStateOnHorizontalDrag(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // swiping in right direction
      _slideController.setMoonState();
    } else {
      // swiping in left direction
      _slideController.setSunState();
    }
    setState(() {});
    if (_slideController.prevState != _slideController.state) {
      widget.valueChanged(_slideController.state);
      _slideController.prevState = _slideController.state;
    }
  }
}
