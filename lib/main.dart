import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_book/pages/login_page.dart';
import 'package:note_book/themeProvider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  await Hive.initFlutter();
  await Hive.openBox("taskBox");
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          theme: themeProvider.themeData,
          debugShowCheckedModeBanner: false,
          home: const LoginPage(),
        );
      },
    );
  }
}
