import 'package:flutter/material.dart';
import 'package:inkwell_splash/inkwell_splash.dart';

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
