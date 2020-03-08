# darkmode_switcher

**darkmode_switcher** widget for Flutter project.

![](darkmode_switcher.gif)

## Getting Started

For use **darkmode_switcher** widget in your project:
1. Add dependency in the **pubspec.yaml** file
```dart
    dependencies:
        flutter:
            sdk: flutter
        darkmode_switcher:
            git:
                url: git@github.com:shekunsky/FLUTTER-darkmode_switcher.git
```

2. Import widget in the dart file:
```dart
    import 'package:darkmode_switcher/darkmode_switcher.dart';
    import 'package:darkmode_switcher/dark_mode_switcher_state.dart';
```

3. Make an instance of the widget.

    ```dart
         DarkModeSwitcher(
                state: DarkModeSwitcherState.sun,
                valueChanged: (state) {
                  if (state == DarkModeSwitcherState.moon) {
                    print('moon');
                  } else {
                    print('sun');
                  }
                },
              )
    ```
    
    
    ## License

    Windmill Smart Solutions 2020 ©