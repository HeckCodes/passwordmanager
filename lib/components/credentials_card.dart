import 'package:flutter/material.dart';
import 'package:passwordmanager/database/credentials.dart';
import 'package:passwordmanager/screens/view_credentials_page.dart';

class CredentialCard extends StatelessWidget {
  final Credentials credentials;
  final int index;
  const CredentialCard({
    super.key,
    required this.credentials,
    required this.index,
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
              builder: (context) => ViewCredentialsPage(
                credentials: credentials,
                index: index,
              ),
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
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
