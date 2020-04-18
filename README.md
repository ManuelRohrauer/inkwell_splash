# InkWellSplash

[![Pub Package](https://img.shields.io/pub/v/inkwell_splash.svg)](https://pub.dev/packages/inkwell_splash)
[![Buy Me A Beer](https://img.shields.io/badge/Donate-Buy%20me%20a%20Beer-yellow.svg)](https://www.buymeacoffee.com/manuelrohrauer)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.me/ManuelRohrauer)

Flutter package which starts the splash effect of InkWell instantly if `onDoubleTap` is used.
Additionally maximal time between two taps to recognize a double tap can be adjusted.

### Explanation
The problem with the current InkWell is the delayed start of the splash effect while using onDoubleTap

If you are using `onTap` & `onDoubleTap` side by side with an `InkWell`, then a single tap gets delayed. This is necessary for the recognition of a double tap but also the splash effect is delayed. With this package the splash effect is startet instantly.

All other functions are equal to the standard `InkWell` widget

[Interactive Example](https://dartpad.dev/embed-flutter.html?gh_owner=ManuelRohrauer&gh_repo=inkwell_splash&gh_path=dartpad_example&run=true)
 
### Usage
Add this line to pubspec.yaml
```yaml
dependencies:
  inkwell_splash: ^0.0.1
```
Import package
```dart
import 'package:inkwell_splash/inkwell_splash.dart';
```
Simple example:
```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.redAccent,
      child: InkWellSplash(
        splashFactory: InkRipple.splashFactory,
        onTap: () => print("Single Tap"),
        onDoubleTap: () => print("Double Tap"),
        doubleTapTime: Duration(milliseconds: 300),
        child: Container(
          width: 120,
          height: 120,
          child: Text("Welcome to InkWellSplash"),
        ),
      ),
    );
  }
}
```

### Parameters

| Parameter | Description | Type |
|---|---|---|
| `doubleTapTime` | Maximal time between two taps to recognize a double tap | `Duration` |

Additional all parameters of standard InkWell can be used as well

### Note
If another parent or child gesture widget (e.g. InkWell, GestureDetector) uses its own `onDoubleTap` function, the splash of the InkWellSplash is delayed again. This is because, the onTap function of all widgets will then be delayed.

