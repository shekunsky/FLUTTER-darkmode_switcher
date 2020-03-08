import 'package:flutter_test/flutter_test.dart';
import 'package:darkmode_switcher/darkmode_switcher.dart';
import 'package:darkmode_switcher/dark_mode_switcher_state.dart';

void main() {
  testWidgets('Widget changed his state on tap and callback is executed',
      (WidgetTester tester) async {
    int _callbackCounter = 0;
    DarkModeSwitcherState _currentState = DarkModeSwitcherState.sun;

    // Create the widget by telling the tester to build it.
    DarkModeSwitcher _switcher = DarkModeSwitcher(
      state: _currentState,
      valueChanged: (state) {
        _currentState = state;
        _callbackCounter++;
      },
    );

    // Build the widget.
    await tester.pumpWidget(_switcher);

    // Tap the switcher while current state is 'sun'.
    await tester.tap(find.byType(DarkModeSwitcher));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Expect to state changed to 'Moon' and callback executed
    expect(_currentState, DarkModeSwitcherState.moon);
    expect(_callbackCounter, 1);

    // Tap the switcher while current state is 'Moon'.
    await tester.tap(find.byType(DarkModeSwitcher));

    // Rebuild the widget after the state has changed.
    await tester.pump();

    // Expect to state changed to 'sun' and callback executed
    expect(_currentState, DarkModeSwitcherState.sun);
    expect(_callbackCounter, 2);
  });
}
