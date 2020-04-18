library inkwell_splash;

import 'package:flutter/material.dart';
import 'dart:async';

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

  Timer doubleTapTimer;
  bool isPressed = false;
  bool isSingleTap = false;
  bool isDoubleTap = false;

  void _doubleTapTimerElapsed() {
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
      doubleTapTimer = Timer(doubleTapTime, _doubleTapTimerElapsed);
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
      onTap: (onDoubleTap != null) ? _onTap : onTap,    // if onDoubleTap is not used from user, then route further to onTap
      onLongPress: onLongPress,
      onTapDown: (onDoubleTap != null) ? _onTapDown : onTapDown,
      onTapCancel: (onDoubleTap != null) ? _onTapCancel : onTapCancel,
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
