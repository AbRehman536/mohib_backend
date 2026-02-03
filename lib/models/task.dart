// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

class TaskModel {
  final String? docId;
  final String? title;
  final String? description;
  final String? priorityID;
  final bool? isCompleted;
  final List<dynamic>? favorite;
  final int? createdAt;

  TaskModel({
    this.docId,
    this.title,
    this.description,
    this.favorite,
    this.priorityID,
    this.isCompleted,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    docId: json["docID"],
    title: json["title"],
    description: json["description"],
    priorityID: json["priorityID"],
    isCompleted: json["isCompleted"],
    favorite: json["favorite"] == null ? [] : List<dynamic>.from(json["favorite"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String taskID) => {
    "docID": taskID,
    "title": title,
    "description": description,
    "priorityID": priorityID,
    "isCompleted": isCompleted,
    "favorite": favorite == null ? [] : List<dynamic>.from(favorite!.map((x) => x)),
    "createdAt": createdAt,
  };
}
