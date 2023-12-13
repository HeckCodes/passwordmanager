// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_credentials.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginCredentialsAdapter extends TypeAdapter<LoginCredentials> {
  @override
  final int typeId = 1;

  @override
  LoginCredentials read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginCredentials(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as DateTime,
      fields[8] as DateTime,
      fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LoginCredentials obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.totp)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.uri)
      ..writeByte(6)
      ..write(obj.folderId)
      ..writeByte(7)
      ..write(obj.creationDate)
      ..writeByte(8)
      ..write(obj.revisionDate)
      ..writeByte(9)
      ..write(obj.favorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginCredentialsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
