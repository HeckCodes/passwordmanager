import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordmanager/database/credentials.dart';
import 'package:passwordmanager/screens/home_page.dart';
import 'package:passwordmanager/theme/themes.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Credentials>(CredentialsAdapter());

  const secureStorage = FlutterSecureStorage();
  final key = await secureStorage.read(key: 'encryption-key');
  if (key == null) {
    await secureStorage.write(key: 'encryption-key', value: base64UrlEncode(Hive.generateSecureKey()));
  }

  final encodedKeyStr = await secureStorage.read(key: 'encryption-key');
  final encryptionKey = base64Url.decode(encodedKeyStr!);

  await Hive.openBox<Credentials>(credentialsBoxName, encryptionCipher: HiveAesCipher(encryptionKey));

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Heck-Pass',
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: ThemeMode.system,
      home: const Root(),
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
