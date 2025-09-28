library ndmg;

import 'package:chopper/chopper.dart';
import 'src/notion_api_service.dart';

export 'src/notion_api_service.dart';

Future<Response<Map<String, dynamic>>> queryNotionDatabase({
  required String authToken,
  required String databaseId,
  Map<String, dynamic> body = const {},
  String notionVersion = NotionApiService.defaultNotionVersion,
}) async {
  final service = NotionApiService.create(
    authToken: authToken,
    notionVersion: notionVersion,
  );

  try {
    return await service.queryDatabase(
      databaseId,
      body: body,
    );
  } finally {
    service.client.dispose();
  }
}
