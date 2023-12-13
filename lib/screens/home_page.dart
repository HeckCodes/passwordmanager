import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
    );
  }
}
