import 'package:flutter/material.dart';

class UserIcon extends StatelessWidget {
  final String userId;
  final double size;
  const UserIcon({Key? key, required this.userId, this.size = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration:
          BoxDecoration(color: Colors.blue.shade300, shape: BoxShape.circle),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
            child: Text(
          userId,
          style: TextStyle(fontSize: size * 0.5),
        )),
      ),
    );
  }
}
