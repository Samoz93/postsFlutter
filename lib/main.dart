import 'package:flutter/material.dart';
import 'package:igor/main.vm.dart';
import 'package:stacked/stacked.dart';
import 'Ui/pages/main/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      onModelReady: (v) => v.init(),
      builder: (context, model, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (ctx) => HomePage(),
        },
      ),
    );
  }
}
