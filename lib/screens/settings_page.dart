import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordmanager/services/local_auth_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLocalAuthOn = Hive.box<bool>('preferences').get('localAuthState', defaultValue: false)!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: Theme.of(context).primaryTextTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "Manage the app's behaviour",
                style: Theme.of(context).primaryTextTheme.bodySmall,
              ),
              const SizedBox(height: 32),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          "Biometric Lock",
                          style: Theme.of(context).primaryTextTheme.bodySmall,
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: isLocalAuthOn,
                        activeColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                        onChanged: (value) async {
                          bool auth = await LocalAuth.authenticate();
                          Hive.box<bool>('preferences').put('localAuthState', auth);
                          setState(() {
                            isLocalAuthOn = auth;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
