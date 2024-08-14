// To parse this JSON data, do
//
//     final dropdownItemsModel = dropdownItemsModelFromMap(jsonString);

import 'dart:convert';

List<DropdownItemsModel> dropdownItemsModelFromJson(String str) =>
    List<DropdownItemsModel>.from(
        json.decode(str).map((x) => DropdownItemsModel.fromMap(x)));

String dropdownItemsModelToJson(List<DropdownItemsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class DropdownItemsModel {
  int userId;
  int id;
  String title;

  DropdownItemsModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory DropdownItemsModel.fromMap(Map<String, dynamic> json) =>
      DropdownItemsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
