import 'package:ndmg/ndmg.dart';
import 'package:test/test.dart';

void main() {
  group('NotionApiService', () {
    test('노션 버전으로 서비스를 생성한다', () {
      final service = NotionApiService.create(
        authToken: 'test_token',
      );

      expect(service, isA<NotionApiService>());
    });

    test('올바른 기본 노션 버전을 가져야 한다', () {
      expect(NotionApiService.defaultNotionVersion, equals('2022-06-28'));
    });
  });

  group('queryNotionDatabase', () {
    test('필수 파라미터를 받을 수 있어야 한다', () {
      expect(
        () => queryNotionDatabase(
          authToken: 'test_token',
          databaseId: 'test_database_id',
        ),
        returnsNormally,
      );
    });

    test('선택적 body 파라미터를 받을 수 있어야 한다', () {
      final body = {
        'filter': {
          'property': 'Name',
          'title': {'is_not_empty': true}
        }
      };

      expect(
        () => queryNotionDatabase(
          authToken: 'test_token',
          databaseId: 'test_database_id',
          body: body,
        ),
        returnsNormally,
      );
    });

    test('선택적 notionVersion 파라미터를 받을 수 있어야 한다', () {
      expect(
        () => queryNotionDatabase(
          authToken: 'test_token',
          databaseId: 'test_database_id',
          notionVersion: '2023-01-01',
        ),
        returnsNormally,
      );
    });

    test('body가 제공되지 않을 때 기본 빈 body를 사용해야 한다', () {
      expect(
        () => queryNotionDatabase(
          authToken: 'test_token',
          databaseId: 'test_database_id',
        ),
        returnsNormally,
      );
    });
  });
}
