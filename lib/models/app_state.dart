import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  String? selectedNoteId;

  void selectNote(String noteId) {
    selectedNoteId = noteId;
    notifyListeners();
  }

  void clearSelection() {
    selectedNoteId = null;
    notifyListeners();
  }
}
