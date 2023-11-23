import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: ListView(
          children: [
            ListTile(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2023),
                );
                print(date);
                final time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                print(time);
                final booking = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2023),
                  builder: (context, child) {
                    return Theme(
                      data: ThemeData(
                          appBarTheme: const AppBarTheme(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                          ),
                          useMaterial3: false),
                      child: child!,
                    );
                  },
                );
                print(booking);
              },
              title: const Text(
                "What is your birrthday?",
                style: TextStyle(),
              ),
            ),
            const AboutListTile()
          ],
        ));
  }
}
