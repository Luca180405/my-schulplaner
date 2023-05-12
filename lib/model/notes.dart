final String tableNotes = 'notes';

class NoteFields {
  static final String id = '_id';
  static final String id = 'isImportant';
  static final String id = 'number';
  static final String id = 'title';
  static final String id = 'description';
  static final String id = 'time';
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;
}
