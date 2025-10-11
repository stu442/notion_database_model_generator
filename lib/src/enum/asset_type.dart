// ignore_for_file: constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

enum AssetType {
  file,
  file_upload,
  external,
  emoji;

  factory AssetType.fromJson(String json) {
    return AssetType.values.firstWhere((e) => e.name == json);
  }
}
