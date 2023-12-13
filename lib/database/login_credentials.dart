import 'package:hive/hive.dart';

part 'login_credentials.g.dart';

const String loginDetailsBoxName = 'LoginCredentialsBox';

@HiveType(typeId: 1)
class LoginCredentials {
  @HiveField(0)
  String name;

  @HiveField(1)
  String username;

  @HiveField(2)
  String password;

  @HiveField(3)
  String totp;

  @HiveField(4)
  String notes;

  @HiveField(5)
  String uri;

  @HiveField(6)
  String folderId;

  @HiveField(7)
  DateTime creationDate;

  @HiveField(8)
  DateTime revisionDate;

  @HiveField(9)
  bool favorite;

  LoginCredentials(
    this.name,
    this.username,
    this.password,
    this.totp,
    this.notes,
    this.uri,
    this.folderId,
    this.creationDate,
    this.revisionDate,
    this.favorite,
  );
}
