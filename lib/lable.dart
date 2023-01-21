import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class LabelPainter {
  Future<ByteData> getImageByteData() async {
    int _width = 480;
    int _height = 60;
    ui.PictureRecorder recorder = new ui.PictureRecorder();

    Paint _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    Canvas c = new Canvas(recorder);
    c.drawRRect(RRect.fromLTRBAndCorners(20, 30, 40, 50), _paint);
    _paint.color = Colors.red;
    c.drawRect(Rect.fromLTWH(10, 10, 10, 10), _paint);
    _paint.color = Colors.blue;
    c.drawRect(
        Rect.fromCenter(center: Offset(50, 50), height: 50, width: 50), _paint);
    _paint.color = Colors.pink;
    c.drawRect(
        Rect.fromPoints(
            Offset(0, 0), Offset(_width.toDouble(), _height.toDouble())),
        _paint);
    // c.drawPaint(Paint()); // etc
    ui.Picture p = recorder.endRecording();
    ui.Image _uiImg = await p.toImage(
        _width, _height); //.toByteData(format: ImageByteFormat.png);

    ByteData _byteData =
        await _uiImg.toByteData(format: ui.ImageByteFormat.png);
    return _byteData;
  }
}