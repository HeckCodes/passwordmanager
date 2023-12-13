import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordmanager/components/credentials_card.dart';
import 'package:passwordmanager/database/credentials.dart';
import 'package:passwordmanager/screens/add_credentials_page.dart';
import 'package:passwordmanager/screens/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddCredentialsPage(),
              ),
            );
          },
          child: const Icon(
            Icons.add_rounded,
            color: Colors.white,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'HeckPass',
                        style: Theme.of(context).primaryTextTheme.headlineMedium,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.settings_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'All Credentials',
                  style: Theme.of(context).primaryTextTheme.bodySmall,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box<Credentials>(credentialsBoxName).listenable(),
                    builder: (context, box, _) {
                      if (box.values.isEmpty) {
                        return const Center(
                          child: Text('No login details present :/'),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: box.values.length,
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        itemBuilder: (context, index) {
                          final idx = box.values.length - index - 1;
                          return CredentialCard(
                            index: idx,
                            credentials: box.getAt(idx) ??
                                Credentials(
                                  "name",
                                  "username",
                                  "password",
                                  "totp",
                                  "notes",
                                  "uri",
                                  "folderId",
                                  DateTime.now(),
                                  DateTime.now(),
                                  false,
                                ),
                          );
                        },
                      );
                    },
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
