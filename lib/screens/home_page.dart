import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordmanager/database/login_credentials.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Heck\'s Password Manager'),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new login',
        onPressed: () {},
        child: const Icon(Icons.add_rounded),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<LoginCredentials>(loginDetailsBoxName).listenable(),
        builder: (context, box, _) {
          if (box.values.isEmpty) {
            return const Center(
              child: Text('No login details present'),
            );
          }

          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              return Card(
                child: Text(box.getAt(index)!.name),
              );
            },
          );
        },
      ),
    );
  }
}
