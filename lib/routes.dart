import 'package:auto_route/auto_route.dart';
import 'package:pds/screens/note_details_screen.dart';
import 'package:pds/screens/note_edit_screen.dart';
import 'package:pds/screens/notes_list_screen.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: [
  RedirectRoute(path: '/', redirectTo: '/notes'),
  AutoRoute(path: '/notes', page: NotesListScreen, initial: true),
  AutoRoute(path: '/notes/:noteId', page: NoteDetailsScreen),
  AutoRoute(path: '/notes/:noteId/edit', page: NoteEditScreen),
])
class $AppRouter {}
