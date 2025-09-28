// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notion_api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$NotionApiService extends NotionApiService {
  _$NotionApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = NotionApiService;

  @override
  Future<Response<Map<String, dynamic>>> queryDatabase(
    String databaseId, {
    Map<String, dynamic> body = const {},
  }) {
    final Uri $url = Uri.parse('/databases/${databaseId}/query');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<Map<String, dynamic>, Map<String, dynamic>>($request);
  }
}
