// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  TaskModel({
    this.detail,
    this.task,
  });

  String detail;
  Task task;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    detail: json["detail"] == null ? null : json["detail"],
    task: json["task"] == null ? null : Task.fromJson(json["task"]),
  );

  Map<String, dynamic> toJson() => {
    "detail": detail == null ? null : detail,
    "task": task == null ? null : task.toJson(),
  };
}

class Task {
  Task({
    this.title,
    this.isCompleted,
    this.dueDate,
    this.comments,
    this.description,
    this.tags,
    this.token,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String title;
  int isCompleted;
  DateTime dueDate;
  String comments;
  String description;
  String tags;
  String token;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json["title"] == null ? null : json["title"],
    isCompleted: json["is_completed"] == null ? null : json["is_completed"],
    dueDate: json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
    comments: json["comments"] == null ? null : json["comments"],
    description: json["description"] == null ? null : json["description"],
    tags: json["tags"] == null ? null : json["tags"],
    token: json["token"] == null ? null : json["token"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"] == null ? null : json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "is_completed": isCompleted == null ? null : isCompleted,
    "due_date": dueDate == null ? null : "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
    "comments": comments == null ? null : comments,
    "description": description == null ? null : description,
    "tags": tags == null ? null : tags,
    "token": token == null ? null : token,
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "id": id == null ? null : id,
  };
}
