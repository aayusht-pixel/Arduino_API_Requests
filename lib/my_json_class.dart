// To parse this JSON data, do
// final myJsonClass = myJsonClassFromJson(jsonString);

import 'dart:convert'; // conversion library

List<MyJsonClass> myJsonClassFromJson(String str) => List<MyJsonClass>.from(
    json.decode(str).map((x) => MyJsonClass.fromJson(x)));

String myJsonClassToJson(List<MyJsonClass> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyJsonClass {
  MyJsonClass({
    required this.createdAt,
    required this.href,
    required this.id,
    required this.lastValue,
    required this.name,
    required this.permission,
    required this.persist,
    required this.tag,
    required this.thingId,
    required this.thingName,
    required this.type,
    required this.updateParameter,
    required this.updateStrategy,
    required this.updatedAt,
    required this.valueUpdatedAt,
    required this.variableName,
  });

  DateTime createdAt;
  String href;
  String id;
  dynamic lastValue;
  String name;
  String permission;
  bool persist;
  int tag;
  String thingId;
  String thingName;
  String type;
  int updateParameter;
  String updateStrategy;
  DateTime updatedAt;
  DateTime valueUpdatedAt;
  String variableName;

  factory MyJsonClass.fromJson(Map<String, dynamic> json) => MyJsonClass(
        createdAt: DateTime.parse(json["created_at"]),
        href: json["href"],
        id: json["id"],
        lastValue: json["last_value"],
        name: json["name"],
        permission: json["permission"],
        persist: json["persist"],
        tag: json["tag"],
        thingId: json["thing_id"],
        thingName: json["thing_name"],
        type: json["type"],
        updateParameter: json["update_parameter"],
        updateStrategy: json["update_strategy"],
        updatedAt: DateTime.parse(json["updated_at"]),
        valueUpdatedAt: DateTime.parse(json["value_updated_at"]),
        variableName: json["variable_name"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "href": href,
        "id": id,
        "last_value": lastValue,
        "name": name,
        "permission": permission,
        "persist": persist,
        "tag": tag,
        "thing_id": thingId,
        "thing_name": thingName,
        "type": type,
        "update_parameter": updateParameter,
        "update_strategy": updateStrategy,
        "updated_at": updatedAt.toIso8601String(),
        "value_updated_at": valueUpdatedAt.toIso8601String(),
        "variable_name": variableName,
      };
}