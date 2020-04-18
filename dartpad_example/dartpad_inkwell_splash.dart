import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int inkWellTaps = 0;
  int inkWellDoubleTaps = 0;
  int inkWellSplashTaps = 0;
  int inkWellSplashDoubleTaps = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Material(
          color: Colors.redAccent,
          child: InkWell(
            splashFactory: InkRipple.splashFactory,
            onTap: () => setState(() => inkWellTaps++),
            onDoubleTap: () => setState(() => inkWellDoubleTaps++),
            child: Container(
              alignment: Alignment.center,
              width: 120,
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Standard InkWell', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('Taps: $inkWellTaps'),
                  Text('Double Taps: $inkWellDoubleTaps'),
                ],
              ),
            ),
          ),
        ),
        Material(
          color: Colors.redAccent,
          child: InkWellSplash(
            splashFactory: InkRipple.splashFactory,
            onTap: () => setState(() => inkWellSplashTaps++),
            onDoubleTap: () => setState(() => inkWellSplashDoubleTaps++),
            doubleTapTime: Duration(milliseconds: 300),
            child: Container(
              width: 120,
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('InkWellSplash', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('Taps: $inkWellSplashTaps'),
                  Text('Double Taps: $inkWellSplashDoubleTaps'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// This is the actual package file, this is here to use the interactive example with dartpad correctly
class InkWellSplash extends StatelessWidget {
  InkWellSplash({
    Key key,
    this.child,
    this.onTap,
    this.onDoubleTap,
    this.doubleTapTime = const Duration(milliseconds: 300),
    this.onLongPress,
    this.onTapDown,
    this.onTapCancel,
    this.onHighlightChanged,
    this.onHover,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.splashFactory,
    this.radius,
    this.borderRadius,
    this.customBorder,
    this.enableFeedback = true,
    this.excludeFromSemantics = false,
    this.focusNode,
    this.canRequestFocus = true,
    this.onFocusChange,
    this.autofocus = false,
  })  : assert(enableFeedback != null),
        assert(excludeFromSemantics != null),
        assert(autofocus != null),
        assert(canRequestFocus != null),
        super(key: key);

  final Widget child;
  final GestureTapCallback onTap;
  final GestureTapCallback onDoubleTap;
  final Duration doubleTapTime;
  final GestureLongPressCallback onLongPress;
  final GestureTapDownCallback onTapDown;
  final GestureTapCancelCallback onTapCancel;
  final ValueChanged<bool> onHighlightChanged;
  final ValueChanged<bool> onHover;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color splashColor;
  final InteractiveInkFeatureFactory splashFactory;
  final double radius;
  final BorderRadius borderRadius;
  final ShapeBorder customBorder;
  final bool enableFeedback;
  final bool excludeFromSemantics;
  final FocusNode focusNode;
  final bool canRequestFocus;
  final ValueChanged<bool> onFocusChange;
  final bool autofocus;

  Timer doubleTapTimer;// = Timer(Duration(milliseconds: 0), null);
  bool isPressed = false;
  bool isSingleTap = false;
  bool isDoubleTap = false;

  void doubleTapTimerElapsed() {
    if (isPressed) {
      isSingleTap = true;
    } else {
      if(this.onTap != null) this.onTap();
    }
  }

  void _onTap() {
    isPressed = false;
    if (isSingleTap) {
      isSingleTap = false;
      if(this.onTap != null) this.onTap();           // call user onTap function
    }
    if (isDoubleTap) {
      isDoubleTap = false;
      if(this.onDoubleTap != null) this.onDoubleTap();
    }
  }

  void _onTapDown(TapDownDetails details) {
    isPressed = true;
    if (doubleTapTimer != null && doubleTapTimer.isActive) {
      isDoubleTap = true;
      doubleTapTimer.cancel();
    } else {
      doubleTapTimer = Timer(doubleTapTime, doubleTapTimerElapsed);
    }
    if(this.onTapDown != null) this.onTapDown(details);
  }

  void _onTapCancel() {
    isPressed = isSingleTap = isDoubleTap = false;
    doubleTapTimer.cancel();
    if(this.onTapCancel != null) this.onTapCancel();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: key,
      child: child,
      onTap: _onTap,
      //onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      onTapDown: _onTapDown,
      onTapCancel: _onTapCancel,
      onHighlightChanged: onHighlightChanged,
      onHover: onHover,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      splashFactory: splashFactory,
      radius: radius,
      borderRadius: borderRadius,
      customBorder: customBorder,
      enableFeedback: enableFeedback,
      excludeFromSemantics: excludeFromSemantics,
      focusNode: focusNode,
      canRequestFocus: canRequestFocus,
      onFocusChange: onFocusChange,
      autofocus: autofocus,
    );
  }
}
