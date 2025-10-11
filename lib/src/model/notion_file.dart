import 'package:json_annotation/json_annotation.dart';
import 'package:ndmg/src/enum/asset_type.dart';

part 'notion_file.g.dart';

/// NotionAsset represents different types of assets that can be used in Notion.
///
/// This sealed class handles four distinct asset types:
/// - File type: Notion-hosted files (uploaded via UI)
/// - File upload type: Files uploaded via the Notion API
/// - External type: External files referenced by URL
/// - Emoji type: Emoji characters used as icons
///
/// Each type has its own specific data structure and properties.

class NotionAsset {
  final AssetType type;
  final NotionAssetType assetType;
  const NotionAsset({required this.type, required this.assetType});

  factory NotionAsset.fromJson(Map<String, dynamic> json) {
    final type = AssetType.fromJson(json['type']);
    final assetType = NotionAssetType.fromJson(json, type);
    return NotionAsset(type: type, assetType: assetType);
  }
}

sealed class NotionAssetType {
  const NotionAssetType();

  factory NotionAssetType.fromJson(Map<String, dynamic> json, AssetType type) {
    switch (type) {
      case AssetType.external:
        return NotionExternalFile.fromJson(json[AssetType.external.name]);
      case AssetType.file:
        return NotionFile.fromJson(json[AssetType.file.name]);
      case AssetType.file_upload:
        return NotionFileUpload.fromJson(json[AssetType.file_upload.name]);
      case AssetType.emoji:
        return NotionEmoji.fromString(json[AssetType.emoji.name]);
    }
  }
}

/// NotionFile represents a file in a Notion workspace.
///
/// These are files that users upload manually through the Notion app - such as dragging an image into a page, adding a PDF block, or setting a page cover.
///
/// When to use:
/// - You're working with existing content in a Notion workspace.
/// - You're accessing files that users manually added via drag-and-drop or upload.
///
/// Tips:
/// - Each time you fetch a Notion-hosted file, it includes a temporary public url vaild for 1 hour.
/// - Don't cache or statically reference these RULs. To refresh access, re-fetch the file object.
///
/// NotionFile handles both file objects and emoji objects in this project.
///
/// This unified approach allows the same class to represent:
/// - File assets (hosted, uploaded, external)
/// - Emoji assets (character icons)
///
/// [this reference](https://developers.notion.com/reference/file-object#notion-hosted-files-type-file).
@JsonSerializable(createToJson: false)
class NotionFile extends NotionAssetType {
  /// An authenticated HTTP GET URL to the file.
  ///
  /// The URL is vaild for one hour.
  /// if the link expires, send an API request to get an updated URL.
  ///
  /// Example Value: "https://s3.us-west-2.amazonaws.com/secure.notion-static.com/9bc6c6e0-32b8-4d55-8c12-3ae931f43a01/brocolli.jpeg?..."
  final String url;

  /// the date and time when the link expires.
  ///
  /// ISO 8601 format.
  ///
  /// Example Value: "2025-01-01T00:00:00.000Z"
  @JsonKey(name: 'expiry_time')
  final String expiryTime;

  const NotionFile({required this.url, required this.expiryTime});

  factory NotionFile.fromJson(Map<String, dynamic> json) =>
      _$NotionFileFromJson(json);
}

/// There are files uploaded using the File Upload API. You first create a [File Upload](https://developers.notion.com/reference/file-upload) object, then upload the file to the URL returned in the file upload object.
///
///
@JsonSerializable(createToJson: false)
class NotionFileUpload extends NotionAssetType {
  final String id;

  const NotionFileUpload({required this.id});

  factory NotionFileUpload.fromJson(Map<String, dynamic> json) =>
      _$NotionFileUploadFromJson(json);
}

@JsonSerializable(createToJson: false)
class NotionExternalFile extends NotionAssetType {
  final String url;

  const NotionExternalFile({required this.url});

  factory NotionExternalFile.fromJson(Map<String, dynamic> json) =>
      _$NotionExternalFileFromJson(json);
}

class NotionEmoji extends NotionAssetType {
  final String? emoji;

  const NotionEmoji({this.emoji});

  factory NotionEmoji.fromString(String emoji) => NotionEmoji(emoji: emoji);
}
