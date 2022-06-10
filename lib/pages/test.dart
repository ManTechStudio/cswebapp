import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  Test({Key? key, int? index})
      : i = index,
        super(key: key);
  int? i = 0;

  @override
  Widget build(BuildContext context) {
    return Text("$i");
  }
}
