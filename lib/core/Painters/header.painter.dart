import 'package:flutter/cupertino.dart';

class HeaderClipper extends CustomClipper<Path> {
  final double perc;
  HeaderClipper({this.perc = 0});
  @override
  Path getClip(Size size) {
    final pth = Path();
    final yClip = size.height * perc;
    var controlPoint = Offset(size.width * 0.5, size.height * 1.2);
    var endPoint = Offset(0, yClip);

    pth
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, yClip)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);

    return pth;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
