import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:passwordmanager/database/login_credentials.dart';

class ViewLoginPage extends StatefulWidget {
  const ViewLoginPage({super.key});

  @override
  State<ViewLoginPage> createState() => _ViewLoginPageState();
}

class _ViewLoginPageState extends State<ViewLoginPage> {
  final loginDetialsFormKey = GlobalKey<FormState>();

  bool isEditing = false;

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final totpController = TextEditingController();
  final notesController = TextEditingController();
  final uriController = TextEditingController();

  String defaultFolderId = 'Default';
  bool favourite = false;

  void encryptAndSaveOnExit() {
    if (loginDetialsFormKey.currentState!.validate()) {
      final now = DateTime.now();
    }
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
          onPressed: encryptAndSaveOnExit,
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
                      'Login Details',
                      style: Theme.of(context).primaryTextTheme.headlineMedium,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Login title',
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
                      readOnly: !isEditing,
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
                      readOnly: !isEditing,
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
                      readOnly: !isEditing,
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
                      'One Time Password (TOTP)',
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: totpController,
                      textCapitalization: TextCapitalization.none,
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      readOnly: !isEditing,
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
                      readOnly: !isEditing,
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
                      'Notes',
                      style: Theme.of(context).primaryTextTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: notesController,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.multiline,
                      maxLines: 50,
                      readOnly: !isEditing,
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
                    const Text(
                      'Details are stored locally on device and are encrypted with AES-256 (32 bytes) encryption key.',
                      textAlign: TextAlign.center,
                    ),
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
