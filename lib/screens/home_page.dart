import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordmanager/database/login_credentials.dart';
import 'package:passwordmanager/screens/add_login_page.dart';

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
                builder: (context) => const AddLoginPage(),
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
                Text(
                  'Heck\'s Password Manager',
                  style: Theme.of(context).primaryTextTheme.headlineMedium,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder(
                  valueListenable: Hive.box<LoginCredentials>(loginDetailsBoxName).listenable(),
                  builder: (context, box, _) {
                    if (box.values.isEmpty) {
                      return const Center(
                        child: Text('No login details present'),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Text(box.getAt(index)!.name),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
