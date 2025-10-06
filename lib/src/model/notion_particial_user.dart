import 'package:ndmg/src/enum/user_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notion_particial_user.g.dart';

@JsonSerializable(createToJson: false)

/// The User object represents a user in a Notion workspace.
/// Users include full workspace members, guests, and integrations.
///
/// You can find more information about members and guests in [this guide](https://www.notion.com/ko/help/add-members-admins-guests-and-groups).
class NotionParticialUser {
  /// Alway "user"
  ///
  /// Exmaple Value: "user"
  final String object;

  /// Unique identifier for this user.
  ///
  /// Example Value: "e79a0b74-3aba-4149-9f74-0bb5791a6ee6"
  final String id;

  /// Type of the user.
  /// Possible values are "person" and "bot".
  ///
  /// Example Value: "person"
  final UserType? type;

  /// User's name, as displayed in Notion.
  ///
  /// Example Value: "John Doe"
  final String? name;

  /// User's name, as displayed in Notion.
  ///
  /// Example Value: "https://secure.notion-static.com/e6a352a8-8381-44d0-a1dc-9ed80e62b53d.jpg"
  final String? avatarUrl;

  NotionParticialUser(
      {required this.object,
      required this.id,
      this.type,
      this.name,
      this.avatarUrl});

  factory NotionParticialUser.fromJson(Map<String, dynamic> json) =>
      _$NotionParticialUserFromJson(json);
}
