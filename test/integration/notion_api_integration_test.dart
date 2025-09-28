import 'dart:convert';
import 'dart:io';
import 'package:ndmg/ndmg.dart';
import 'package:test/test.dart';

Map<String, dynamic>? _loadConfig() {
  try {
    final configFile = File('ndmg.json');
    if (!configFile.existsSync()) {
      return null;
    }
    final content = configFile.readAsStringSync();
    return json.decode(content) as Map<String, dynamic>;
  } catch (e) {
    return null;
  }
}

void main() {
  group('실제 API 호출 통합 테스트', () {
    late Map<String, dynamic>? config;

    setUpAll(() {
      config = _loadConfig();
    });

    test('실제 노션 데이터베이스를 쿼리할 수 있어야 한다', () async {
      if (config == null) {
        markTestSkipped('ndmg.json 설정 파일이 없어서 실제 API 테스트를 건너뜁니다.');
        return;
      }

      final response = await queryNotionDatabase(
        authToken: config!['token'] as String,
        databaseId: config!['databaseId'] as String,
      );

      expect(response.statusCode, equals(200));
      expect(response.body, isNotNull);
      expect(response.body!['object'], equals('list'));
      expect(response.body!['results'], isA<List>());
    });

    test('페이지 크기를 제한하여 쿼리할 수 있어야 한다', () async {
      if (config == null) {
        markTestSkipped('ndmg.json 설정 파일이 없어서 실제 API 테스트를 건너뜁니다.');
        return;
      }

      final body = {
        'page_size': 5,
      };

      final response = await queryNotionDatabase(
        authToken: config!['token'] as String,
        databaseId: config!['databaseId'] as String,
        body: body,
      );

      expect(response.statusCode, equals(200));
      expect(response.body, isNotNull);
      expect(response.body!['object'], equals('list'));
      expect(response.body!['results'], isA<List>());

      final results = response.body!['results'] as List;
      expect(results.length, lessThanOrEqualTo(5));
    });

    test('정렬 옵션으로 쿼리할 수 있어야 한다', () async {
      if (config == null) {
        markTestSkipped('ndmg.json 설정 파일이 없어서 실제 API 테스트를 건너뜁니다.');
        return;
      }

      final body = {
        'sorts': [
          {'timestamp': 'created_time', 'direction': 'descending'}
        ]
      };

      final response = await queryNotionDatabase(
        authToken: config!['token'] as String,
        databaseId: config!['databaseId'] as String,
        body: body,
      );

      expect(response.statusCode, equals(200));
      expect(response.body, isNotNull);
      expect(response.body!['object'], equals('list'));
    });
  });

  group('에러 시나리오 테스트', () {
    late Map<String, dynamic>? config;

    setUpAll(() {
      config = _loadConfig();
    });

    test('잘못된 토큰으로 401 에러가 발생해야 한다', () async {
      if (config == null) {
        markTestSkipped('ndmg.json 설정 파일이 없어서 에러 시나리오 테스트를 건너뜁니다.');
        return;
      }

      final response = await queryNotionDatabase(
        authToken: 'invalid_token',
        databaseId: config!['databaseId'] as String,
      );

      expect(response.statusCode, equals(401));
    });

    test('존재하지 않는 데이터베이스 ID로 404 에러가 발생해야 한다', () async {
      if (config == null) {
        markTestSkipped('ndmg.json 설정 파일이 없어서 에러 시나리오 테스트를 건너뜁니다.');
        return;
      }

      final response = await queryNotionDatabase(
        authToken: config!['token'] as String,
        databaseId: 'invalid-database-id-12345678',
      );

      expect(response.statusCode, anyOf([400, 404]));
    });

    test('잘못된 쿼리 body로 400 에러가 발생해야 한다', () async {
      if (config == null) {
        markTestSkipped('ndmg.json 설정 파일이 없어서 에러 시나리오 테스트를 건너뜁니다.');
        return;
      }

      final body = {
        'invalid_field': 'invalid_value',
        'filter': 'this_should_be_an_object_not_string',
      };

      final response = await queryNotionDatabase(
        authToken: config!['token'] as String,
        databaseId: config!['databaseId'] as String,
        body: body,
      );

      expect(response.statusCode, equals(400));
    });
  });

  group('응답 데이터 검증', () {
    late Map<String, dynamic>? config;

    setUpAll(() {
      config = _loadConfig();
    });

    test('응답 데이터의 기본 구조가 올바른지 확인해야 한다', () async {
      if (config == null) {
        markTestSkipped('ndmg.json 설정 파일이 없어서 응답 데이터 검증을 건너뜁니다.');
        return;
      }

      final response = await queryNotionDatabase(
        authToken: config!['token'] as String,
        databaseId: config!['databaseId'] as String,
      );

      expect(response.statusCode, equals(200));
      expect(response.body, isNotNull);

      final body = response.body!;
      expect(body['object'], equals('list'));
      expect(body['results'], isA<List>());
      expect(body.containsKey('next_cursor'), isTrue);
      expect(body.containsKey('has_more'), isTrue);
    });

    test('결과 항목들이 올바른 페이지 객체 구조를 가져야 한다', () async {
      if (config == null) {
        markTestSkipped('ndmg.json 설정 파일이 없어서 응답 데이터 검증을 건너뜁니다.');
        return;
      }

      final response = await queryNotionDatabase(
        authToken: config!['token'] as String,
        databaseId: config!['databaseId'] as String,
        body: {'page_size': 1},
      );

      expect(response.statusCode, equals(200));
      final results = response.body!['results'] as List;

      if (results.isNotEmpty) {
        final firstPage = results.first as Map<String, dynamic>;
        expect(firstPage['object'], equals('page'));
        expect(firstPage.containsKey('id'), isTrue);
        expect(firstPage.containsKey('properties'), isTrue);
        expect(firstPage.containsKey('created_time'), isTrue);
        expect(firstPage.containsKey('last_edited_time'), isTrue);
      }
    });
  });
}