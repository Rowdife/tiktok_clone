import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListWheelScrollView(
          useMagnifier: true,
          magnification: 2,
          diameterRatio: 2,
          offAxisFraction: 2,
          itemExtent: 200,
          children: [
            for (var x in [1, 2, 11, 1, 1, 1, 1, 1, 1, 23, 23, 1, 3])
              FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  color: Colors.teal,
                  alignment: Alignment.center,
                  child: const Text(
                    "Pick me",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          ],
        ));
  }
}
