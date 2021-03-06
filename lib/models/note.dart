import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Note extends Equatable {
  final String id;
  final String title;
  final String content;

  const Note({required this.id, required this.title, required this.content});

  Note copyWith({String? id, String? title, String? content}) => Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
      );

  @override
  List<Object> get props => [id, title, content];

  @override
  bool get stringify => true;
}
