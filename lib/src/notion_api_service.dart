import 'package:chopper/chopper.dart';

part 'notion_api_service.chopper.dart';

@ChopperApi()
abstract class NotionApiService extends ChopperService {
  static const defaultNotionVersion = '2022-06-28';

  static NotionApiService create({
    required String authToken,
    String notionVersion = defaultNotionVersion,
  }) {
    final client = ChopperClient(
      baseUrl: Uri.parse('https://api.notion.com/v1'),
      services: [
        _$NotionApiService(),
      ],
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      interceptors: [
        HeadersInterceptor({
          'Authorization': 'Bearer $authToken',
          'Notion-Version': notionVersion,
          'Content-Type': 'application/json; charset=utf-8',
        }),
      ],
    );

    return client.getService<NotionApiService>();
  }

  @POST(path: '/databases/{databaseId}/query')
  Future<Response<Map<String, dynamic>>> queryDatabase(
    @Path('databaseId') String databaseId, {
    @Body() Map<String, dynamic> body = const {},
  });
}
