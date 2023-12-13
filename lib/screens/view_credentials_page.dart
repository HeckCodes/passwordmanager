import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:otp_repository/otp_repository.dart';
import 'package:passwordmanager/database/credentials.dart';

class ViewCredentialsPage extends StatefulWidget {
  final Credentials credentials;
  const ViewCredentialsPage({
    super.key,
    required this.credentials,
  });

  @override
  State<ViewCredentialsPage> createState() => _ViewCredentialsPageState();
}

class _ViewCredentialsPageState extends State<ViewCredentialsPage> {
  final loginDetialsFormKey = GlobalKey<FormState>();

  bool isEditing = false;

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final totpController = TextEditingController();
  final totpCodeController = TextEditingController();
  final notesController = TextEditingController();
  final uriController = TextEditingController();

  late String defaultFolderId;
  late bool favourite;

  late DateTime creationDate;
  late DateTime revisionDate;

  bool showPassword = false;
  bool showTotp = false;

  void saveAndExit() {
    if (loginDetialsFormKey.currentState!.validate()) {
      final revisionDate = DateTime.now();
      Hive.box<Credentials>(credentialsBoxName)
          .putAt(
            widget.credentials.key,
            Credentials(
              nameController.text.trim(),
              usernameController.text.trim(),
              passwordController.text,
              totpController.text.trim(),
              notesController.text,
              uriController.text.trim(),
              defaultFolderId,
              creationDate,
              revisionDate,
              favourite,
            ),
          )
          .then((value) => Navigator.of(context).pop());
    }
  }

  void setData() {
    nameController.text = widget.credentials.name;
    usernameController.text = widget.credentials.username;
    passwordController.text = widget.credentials.password;
    totpController.text = widget.credentials.totpSecret ?? '';
    notesController.text = widget.credentials.notes ?? '';
    uriController.text = widget.credentials.uri ?? '';
    creationDate = widget.credentials.creationDate;
    revisionDate = widget.credentials.revisionDate;
    defaultFolderId = widget.credentials.folderId;
    favourite = widget.credentials.favourite;
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    totpController.dispose();
    notesController.dispose();
    uriController.dispose();
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
        floatingActionButton: !isEditing
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isEditing = true;
                  });
                },
                child: const Icon(
                  Icons.edit_note_rounded,
                  color: Colors.white,
                ),
              )
            : FloatingActionButton(
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
                      obscureText: !showPassword,
                      maxLines: 1,
                      readOnly: !isEditing,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.password_rounded),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye_rounded),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
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
                      readOnly: !isEditing,
                      obscureText: !showTotp,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.enhanced_encryption_rounded),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye_rounded),
                          onPressed: () {
                            setState(() {
                              showTotp = !showTotp;
                            });
                          },
                        ),
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
                    const SizedBox(height: 4),
                    TextFormField(
                      controller: totpCodeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
                        prefixIcon: const Icon(Icons.code_rounded),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.refresh_rounded),
                          onPressed: () {
                            if (widget.credentials.totpSecret != null) {
                              setState(() {
                                totpCodeController.text = TOTP(secret: widget.credentials.totpSecret!).now();
                              });
                            }
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.none,
                          ),
                        ),
                        hintText: 'TOTP Code',
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
                    Text("Created at:  ${widget.credentials.creationDate}"),
                    Text("Revisioned: ${widget.credentials.creationDate}"),
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
