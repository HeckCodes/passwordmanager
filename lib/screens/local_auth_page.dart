import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passwordmanager/screens/home_page.dart';
import 'package:passwordmanager/services/local_auth_service.dart';

class LocalAuthPage extends StatelessWidget {
  const LocalAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).appBarTheme.systemOverlayStyle!.statusBarColor,
        statusBarIconBrightness: Theme.of(context).appBarTheme.systemOverlayStyle!.statusBarIconBrightness,
        systemNavigationBarColor: Theme.of(context).appBarTheme.systemOverlayStyle!.systemNavigationBarColor,
        systemNavigationBarIconBrightness:
            Theme.of(context).appBarTheme.systemOverlayStyle!.systemNavigationBarIconBrightness,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Authentication',
                  style: Theme.of(context).primaryTextTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "To access this app, please scan your biometric.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width - 70,
                    child: ElevatedButton(
                      onPressed: () async {
                        LocalAuth.authenticate().then((verified) {
                          if (verified) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),
                              ),
                            );
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.fingerprint_rounded),
                          SizedBox(width: 16),
                          Text(
                            "Authenticate",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
