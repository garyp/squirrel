import 'package:auto_route/auto_route.dart';

import 'screens/note_details_screen.dart';
import 'screens/notes_list_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: [
    RedirectRoute(path: '/', redirectTo: '/notes'),
    AutoRoute(path: '/notes', page: NotesListScreen, initial: true),
    AutoRoute(path: '/notes/:noteId', page: NoteDetailsScreen),
  ]
)
class $AppRouter {}