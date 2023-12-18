import 'package:hive_flutter/hive_flutter.dart';

part 'credentials.g.dart';

const String credentialsBoxName = 'credentialsBox';

@HiveType(typeId: 1)
class Credentials extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String? totpSecret;

  @HiveField(4)
  final String? notes;

  @HiveField(5)
  final String? uri;

  @HiveField(6)
  final String? folderId;

  @HiveField(7)
  final DateTime creationDate;

  @HiveField(8)
  final DateTime revisionDate;

  @HiveField(9)
  final bool favourite;

  Credentials(
    this.name,
    this.username,
    this.password,
    this.totpSecret,
    this.notes,
    this.uri,
    this.folderId,
    this.creationDate,
    this.revisionDate,
    this.favourite,
  );

  static Credentials fromJson(Map<String, dynamic> jsonData) {
    return Credentials(
      jsonData['name'] as String,
      jsonData['username'] as String,
      jsonData['password'] as String,
      jsonData['totpSecret'] == null ? null : jsonData['totpSecret'] as String,
      jsonData['notes'] == null ? null : jsonData['notes'] as String,
      jsonData['uri'] == null ? null : jsonData['uri'] as String,
      jsonData['folderId'] == null ? "Default" : jsonData['folderId'] as String,
      DateTime.parse(jsonData['creationDate']),
      DateTime.parse(jsonData['revisionDate']),
      jsonData['favourite'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonData = <String, dynamic>{};
    jsonData['name'] = name;
    jsonData['username'] = username;
    jsonData['password'] = password;
    jsonData['totpSecret'] = totpSecret;
    jsonData['notes'] = notes;
    jsonData['uri'] = uri;
    jsonData['folderId'] = folderId;
    jsonData['creationDate'] = creationDate.toIso8601String();
    jsonData['revisionDate'] = revisionDate.toIso8601String();
    jsonData['favourite'] = favourite;

    return jsonData;
  }
}
