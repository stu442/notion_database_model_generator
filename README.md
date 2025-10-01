# NDMG (Notion Database Model Generator)

Notion 데이터베이스에서 정의한 API 모델 스키마를 **Dart 모델 코드**로 자동 생성해주는 CLI 툴입니다.
Flutter/Dart 개발자가 **Notion → 코드** 워크플로우를 간단하게 가져갈 수 있도록 도와줍니다.

---

## ✨ Features
- Notion DB에 정의한 스키마를 기반으로 Dart 모델 클래스 생성

---

## 🧪 Testing

### 단위 테스트 (Unit Tests)
빠른 실행, 외부 의존성 없음:
```bash
dart test test/ndmg_test.dart
```

### 통합 테스트 (Integration Tests)
실제 Notion API 호출, `ndmg.json` 설정 파일 필요:
```bash
dart test test/integration/
```

### 모든 테스트 실행
```bash
dart test
```

#### 통합 테스트 설정
통합 테스트를 실행하려면 프로젝트 루트에 `ndmg.json` 파일이 필요합니다:
```json
{
  "token": "your_notion_api_token",
  "databaseId": "your_database_id"
}
```

설정 파일이 없으면 통합 테스트는 자동으로 건너뜁니다.

---
