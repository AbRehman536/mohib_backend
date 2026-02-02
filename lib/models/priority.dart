// To parse this JSON data, do
//
//     final priorityTaskModel = priorityTaskModelFromJson(jsonString);

import 'dart:convert';

class PriorityTaskModel {
  final String? docId;
  final String? name;
  final int? createdAt;

  PriorityTaskModel({
    this.docId,
    this.name,
    this.createdAt,
  });

  factory PriorityTaskModel.fromJson(Map<String, dynamic> json) => PriorityTaskModel(
    docId: json["docId"],
    name: json["name"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String priorityID) => {
    "docId": priorityID,
    "name": name,
    "createdAt": createdAt,
  };
}
