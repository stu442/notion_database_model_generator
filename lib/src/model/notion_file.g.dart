// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notion_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotionFile _$NotionFileFromJson(Map<String, dynamic> json) => NotionFile(
      url: json['url'] as String,
      expiryTime: json['expiry_time'] as String,
    );

NotionFileUpload _$NotionFileUploadFromJson(Map<String, dynamic> json) =>
    NotionFileUpload(
      id: json['id'] as String,
    );

NotionExternalFile _$NotionExternalFileFromJson(Map<String, dynamic> json) =>
    NotionExternalFile(
      url: json['url'] as String,
    );
