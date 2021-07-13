import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'note.dart';

class NoteCollection extends ChangeNotifier {
  final notes = <Note>[];

  Note getById(String id) => notes.firstWhere((note) => note.id == id);

  Note getByPosition(int index) => notes[index];

  Note getByTitle(String title) =>
      notes.singleWhere((note) => note.title == title);

  void add(Note note) {
    notes.add(note);
    notifyListeners();
  }

  String addNewNote() {
    final id = DateFormat('yyyyMMddHHmmssSSS').format(DateTime.now().toUtc());
    notes.add(Note(
      id: id,
      title: 'Untitled ${notes.length}',
      content: '''
## A header

Add some text here... Maybe even a [link to Google](https://www.google.com/)?
Or **some** code:

```py
if foo is True:
  print("hi")
```

Or how about a list?

* Item 1
* Item 2
* Item 3
''',
    ));
    notifyListeners();
    return id;
  }

  void updateNote(String id, String content) {
    final index = notes.indexWhere((note) => note.id == id);
    notes[index] = notes[index].copyWith(content: content);
    notifyListeners();
  }

  Iterable<Note> findNotesWithMatchingTitles(String searchString) {
    return notes.where((note) =>
        note.title.toLowerCase().contains(searchString.toLowerCase()));
  }
}
