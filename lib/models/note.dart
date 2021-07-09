import 'package:flutter/foundation.dart';

@immutable
class Note {
  final String id;
  final String title;
  final String content;

  Note({required this.id, required this.title, required this.content});

  Note copyWith({String? id, String? title, String? content}) => Note(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
  );
}
