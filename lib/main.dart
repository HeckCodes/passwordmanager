import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordmanager/database/login_credentials.dart';

import 'screens/home_page.dart';

final _defaultLightColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.purple);

final _defaultDarkColorScheme = ColorScheme.fromSwatch(primarySwatch: Colors.purple, brightness: Brightness.dark);

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<LoginCredentials>(LoginCredentialsAdapter());
  runApp(
    DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Heck-Pass',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightDynamic ?? _defaultLightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkDynamic ?? _defaultDarkColorScheme,
        ),
        themeMode: ThemeMode.system,
        home: const Root(),
      ),
    ),
  );
}

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
