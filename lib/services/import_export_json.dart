import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:passwordmanager/database/credentials.dart';
import 'package:permission_handler/permission_handler.dart';

void filePermHandler(
  BuildContext context,
  bool isImport,
) {
  DeviceInfoPlugin().androidInfo.then((info) {
    final storagePermStatus = info.version.sdkInt < 33 ? Permission.storage.request() : PermissionStatus.granted;
    switch (storagePermStatus) {
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.denied:
        permDeniedHandler(context);
        break;
      case PermissionStatus.granted:
        isImport ? addCredsFromJson(context) : addCredsToJson(context);
        break;
      default:
        break;
    }
  });
}

void permDeniedHandler(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Permission not granted!'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
      ),
    ),
  );
}

void addCredsFromJson(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text('Permission granted! Pick File'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
      ),
    ),
  );
  FilePicker.platform.pickFiles(allowedExtensions: ['json'], type: FileType.custom).then((result) {
    if (result != null) {
      File file = File(result.files.single.path!);
      addCredsToDB(file, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: const Text('Error getting the file.'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
          ),
        ),
      );
    }
  });
}

void addCredsToDB(File file, BuildContext context) {
  file.readAsString().then((content) {
    var json = jsonDecode(content);
    var items = json['items'];
    var now = DateTime.now().millisecondsSinceEpoch;
    for (var item in items) {
      Hive.box<Credentials>(credentialsBoxName).put((++now).toString(), Credentials.fromJson(item));
    }
    Hive.box<bool>('folders').put("change", !Hive.box<bool>('folders').get("change")!);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text('Credentials imported successfully.'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
        ),
      ),
    );
  });
}

void addCredsToJson(BuildContext context) {
  Map<String, dynamic> jsonData = {
    "items": Hive.box<Credentials>(credentialsBoxName).values.map((e) => e.toJson()).toList()
  };
  final file = File('/storage/emulated/0/Documents/creds.json');

  file.create(recursive: true).then((value) {
    file.writeAsString(jsonEncode(jsonData));
  }, onError: (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: const Text('Failed to save file.'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
        ),
      ),
    );
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text('File saved to documents folder.'),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
      ),
    ),
  );
}
