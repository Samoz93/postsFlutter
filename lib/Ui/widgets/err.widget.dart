import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ErrWidget extends StatelessWidget {
  final dynamic err;
  const ErrWidget({Key? key, required this.err}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(kDebugMode ? "$err" : "Something worng happened!!!"),
    );
  }
}
