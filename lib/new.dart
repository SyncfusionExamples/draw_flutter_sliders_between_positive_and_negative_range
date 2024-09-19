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
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _value = 0.0;
  SfSlider buildHorizontalSlider() {
    return SfSlider(
      showTicks: true,
      showLabels: true,
      min: -10,
      max: 10,
      interval: 5,
      value: _value,
      thumbShape: _CustomThumbShape(type: SliderType.horizontal, value: _value),
      onChanged: (dynamic value) {
        setState(
          () {
            _value = value;
          },
        );
      },
    );
  }

  SfSlider buildVerticalSlider() {
    return SfSlider.vertical(
      showTicks: true,
      showLabels: true,
      min: -10,
      max: 10,
      interval: 5,
      value: _value,
      thumbShape: _CustomThumbShape(type: SliderType.vertical, value: _value),
      onChanged: (dynamic value) {
        setState(
          () {
            _value = value;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final SfColorScheme colorScheme = SfTheme.colorScheme(context);
    return Scaffold(
      body: Center(
        child: SfSliderTheme(
          data: SfSliderThemeData(
            activeTrackColor: colorScheme.primary[61],
            trackCornerRadius: 7.5,
            activeTrackHeight: 10,
            inactiveTrackHeight: 10,
          ),
          child: buildHorizontalSlider(),
        ),
      ),
    );
  }
}

class _CustomThumbShape extends SfThumbShape {
  _CustomThumbShape({required this.type, required this.value});
  final SliderType type;
  final double value;

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
    final Rect? rect;
    final Offset center1 =
        Offset(parentBox.size.width / 2, parentBox.size.height / 2);
    final halfTrackHeight = themeData.activeTrackHeight / 2;
    final x = center.dx;
    final y = center.dy;
    if (type == SliderType.vertical) {
      rect = Rect.fromLTRB(
        x - halfTrackHeight,
        y,
        x + halfTrackHeight,
        parentBox.size.height / 2,
      );
    } else {
      rect = Rect.fromLTRB(
        x,
        y - halfTrackHeight,
        center1.dx,
        y + halfTrackHeight,
      );
    }

    thumbPaint
      ..color =
          value < 0 ? const Color(0XFFC62828) : Colors.orange.withOpacity(0.850)
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
