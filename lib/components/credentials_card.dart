import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordmanager/database/credentials.dart';
import 'package:passwordmanager/screens/view_credentials_page.dart';

class CredentialCard extends StatelessWidget {
  final Credentials credentials;
  const CredentialCard({
    super.key,
    required this.credentials,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewCredentialsPage(credentials: credentials),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: CircleAvatar(
                  child: Text(
                    credentials.name[0],
                    style: const TextStyle(fontSize: 22),
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      credentials.name,
                      style: const TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      credentials.username,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
                                    child: CircleAvatar(
                                      child: Text(
                                        credentials.name[0],
                                        style: const TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        credentials.name,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      Text(credentials.username)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: credentials.username),
                                ).then(
                                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 1),
                                      content: const Text('Username copied to clipboard.'),
                                      action: SnackBarAction(
                                        label: 'Ok',
                                        onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const ListTile(
                                leading: Icon(Icons.text_format_rounded),
                                title: Text('Copy Username'),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: credentials.password),
                                ).then(
                                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(seconds: 1),
                                      content: const Text('Password copied to clipboard.'),
                                      action: SnackBarAction(
                                        label: 'Ok',
                                        onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const ListTile(
                                leading: Icon(Icons.password_rounded),
                                title: Text('Copy Password'),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewCredentialsPage(credentials: credentials),
                                  ),
                                );
                              },
                              child: const ListTile(
                                leading: Icon(Icons.edit_rounded),
                                title: Text('Edit Credentials'),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Hive.box<Credentials>(credentialsBoxName)
                                    .delete(credentials.key)
                                    .then(
                                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          duration: const Duration(seconds: 1),
                                          content: const Text('Deleted Credentials'),
                                          action: SnackBarAction(
                                            label: 'Ok',
                                            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
                                          ),
                                        ),
                                      ),
                                    )
                                    .then((value) => Navigator.of(context).pop());
                              },
                              child: const ListTile(
                                leading: Icon(Icons.delete_rounded),
                                title: Text('Delete Credentials'),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
