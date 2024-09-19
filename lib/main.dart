import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _value = 0.0;
  SfSlider getHorizontalSlider() {
    return SfSlider(
        showTicks: true,
        showLabels: true,
        min: -10,
        max: 10,
        interval: 1,
        value: _value,
        thumbShape: _CustomThumbShape(type: SliderType.horizontal),
        onChanged: (dynamic value) {
          setState(() {
            _value = value;
          });
        });
  }

  SfSlider getVerticalSlider() {
    return SfSlider.vertical(
        showTicks: true,
        showLabels: true,
        min: -10,
        max: 10,
        interval: 1,
        value: _value,
        thumbShape: _CustomThumbShape(type: SliderType.vertical),
        onChanged: (dynamic value) {
          setState(() {
            _value = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    SfColorScheme colorScheme = SfTheme.colorScheme(context);
    return Scaffold(
      body:
          // Horizontal Slider
          // SfSliderTheme(
          //   data: SfSliderThemeData(
          //     activeTrackColor: colorScheme.primary[61],
          //     trackCornerRadius: 7.5,
          //     activeTrackHeight: 10,
          //     inactiveTrackHeight: 10,
          //   ),
          //   child: getHorizontalSlider(),
          // ),

          // Vertical Slider
          SfSliderTheme(
        data: SfSliderThemeData(
          activeTrackColor: colorScheme.primary[61],
          trackCornerRadius: 7.5,
          activeTrackHeight: 10,
          inactiveTrackHeight: 10,
        ),
        child: getVerticalSlider(),
      ),
    );
  }
}

class _CustomThumbShape extends SfThumbShape {
  _CustomThumbShape({required this.type});
  final SliderType type;

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required SfSliderThemeData themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    final Paint thumbPaint = Paint();
    Rect? rect;
    Offset center1 =
        Offset(parentBox.size.width / 2, parentBox.size.height / 2);

    if (type == SliderType.vertical) {
      rect = Rect.fromLTRB(
        center.dx - themeData.activeTrackHeight / 2,
        center.dy,
        center.dx + themeData.activeTrackHeight / 2,
        parentBox.size.height / 2,
      );
    } else {
      rect = Rect.fromLTRB(
        center.dx,
        center.dy - themeData.activeTrackHeight / 2,
        center1.dx,
        center.dy + themeData.activeTrackHeight / 2,
      );
    }

    thumbPaint
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = themeData.activeTrackHeight;

    context.canvas.drawRect(rect, thumbPaint);
    super.paint(context, center,
        parentBox: parentBox,
        child: child,
        themeData: themeData,
        paint: thumbPaint,
        enableAnimation: enableAnimation,
        textDirection: textDirection,
        thumb: thumb);
  }
}

enum SliderType { vertical, horizontal }
