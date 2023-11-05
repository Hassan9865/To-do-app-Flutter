import 'package:flutter/material.dart';
import 'package:note_book/pages/theme.dart';
import 'package:note_book/themeProvider.dart';
import 'package:provider/provider.dart';

class ApnaSwitch extends StatefulWidget {
  @override
  _ApnaSwitchState createState() => _ApnaSwitchState();
}

class _ApnaSwitchState extends State<ApnaSwitch> {
  bool switchValue = true;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: switchValue,
      onChanged: (newValue) {
        setState(() {
          switchValue = newValue;
        });
        final themeProvider =
            Provider.of<ThemeProvider>(context, listen: false);
        if (newValue) {
          themeProvider.setTheme(lightTheme);
        } else {
          themeProvider.setTheme(darkTheme);
        }
      },
    );
  }
}
