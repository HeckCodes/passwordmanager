import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordmanager/database/credentials.dart';

class AddCredentialsPage extends StatefulWidget {
  const AddCredentialsPage({super.key});

  @override
  State<AddCredentialsPage> createState() => _AddCredentialsPageState();
}

class _AddCredentialsPageState extends State<AddCredentialsPage> {
  final loginDetialsFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final totpController = TextEditingController();
  final notesController = TextEditingController();
  final uriController = TextEditingController();
  final folderIdController = TextEditingController();

  bool favourite = false;

  void saveAndExit() {
    if (loginDetialsFormKey.currentState!.validate()) {
      final now = DateTime.now();
      Hive.box<Credentials>(credentialsBoxName)
          .add(
            Credentials(
              nameController.text.trim(),
              usernameController.text.trim(),
              passwordController.text,
              totpController.text.trim(),
              notesController.text,
              uriController.text.trim(),
              folderIdController.text.trim(),
              now,
              now,
              favourite,
            ),
          )
          .then((value) => Navigator.of(context).pop());
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    totpController.dispose();
    notesController.dispose();
    uriController.dispose();
    folderIdController.dispose();
    super.dispose();
  }

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
          onPressed: saveAndExit,
          child: const Icon(
            Icons.check_rounded,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: loginDetialsFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Credentials',
                      style: Theme.of(context).primaryTextTheme.headlineMedium,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Name',
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title.';
                        }
                        return null;
                      },
                      controller: nameController,
                      textCapitalization: TextCapitalization.sentences,
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Website/App name',
                        hintStyle: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 24),
                      ),
                      style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontSize: 24),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Username & Password',
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username/email.';
                        }
                        return null;
                      },
                      controller: usernameController,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.text_format_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Username/Email',
                        hintStyle: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 16),
                      ),
                      style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password.';
                        }
                        return null;
                      },
                      controller: passwordController,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.password_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Password',
                        hintStyle: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 16),
                      ),
                      style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      '2FA Secret Code',
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: totpController,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.enhanced_encryption_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'TOTP Secret',
                        hintStyle: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 16),
                      ),
                      style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'URI / URL',
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: uriController,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.url,
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.link_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Website/App Url',
                        hintStyle: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 16),
                      ),
                      style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Folder Name',
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: folderIdController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.folder_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'Folder name for grouping',
                        hintStyle: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 16),
                      ),
                      style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Notes',
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: notesController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      maxLines: 50,
                      decoration: InputDecoration(
                        constraints: BoxConstraints.loose(const Size(double.infinity, 150)),
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.notes_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                      style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
