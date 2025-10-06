// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notion_particial_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotionParticialUser _$NotionParticialUserFromJson(Map<String, dynamic> json) =>
    NotionParticialUser(
      object: json['object'] as String,
      id: json['id'] as String,
      type: $enumDecodeNullable(_$UserTypeEnumMap, json['type']),
      name: json['name'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
    );

const _$UserTypeEnumMap = {
  UserType.person: 'person',
  UserType.bot: 'bot',
};
