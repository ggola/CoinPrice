import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SpinningBubble extends StatelessWidget {
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      size: 100.0,
      color: Color(0xFF124B5F),
    );
  }
}
