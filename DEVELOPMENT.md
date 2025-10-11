# 개발 과정 (Development Process)

## 프로젝트 개요

- **프로젝트명**: NDMG (Notion Database Model Generator)
- **목적**: Notion 데이터베이스 스키마를 Dart 모델 코드로 자동 생성
- **기술 스택**: Dart, Flutter 3.24.3+, Chopper, JSON Annotation

## 구현해야할 기능

- [x] Dart CLI 프로젝트 구조 설정
- [x] 의존성 관리 (pubspec.yaml)
- [x] 기본 명령어 구조 구현
- [x] Notion API 연동 설정
- [x] Notion API 응답 모델 정의
  - [x] NotionDatabaseModel
  - [x] NotionPage
  - [ ] NotionProperty
  - [x] NotionAsset
  - [x] NotionParent
  - [x] NotionPartialUser
- [x] Enum 타입 정의
  - [x] PropertyType
  - [x] AssetType
  - [x] ParentType
  - [x] UserType
- [ ] 코드 생성 로직 구현
- [ ] 코드 검증 로직
- [x] 기본 명령어 구조
- [ ] Global 옵션 처리
- [ ] Generate 명령어 구조
- [ ] 에러 처리 및 검증
- [x] 단위 테스트 구조
- [x] 통합 테스트 설정
- [ ] 테스트 케이스 작성
