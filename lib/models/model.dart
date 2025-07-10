// lib/models/model.dart

class Book {
  final String name;
  final String ref; // Ex: "Gen" para Gênesis
  final int chaptersCount;

  Book({required this.name, required this.ref, required this.chaptersCount});
}
