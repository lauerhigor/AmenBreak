import 'package:flutter/material.dart';
import 'package:myapp/models/model.dart';
import 'package:myapp/pages/verse_page.dart';

// --- PÁGINA DE SELEÇÃO DE CAPÍTULO ---
class ChapterVersePage extends StatelessWidget {
  final Book book;

  const ChapterVersePage({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          book.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
        ),
        itemCount: book.chaptersCount,
        itemBuilder: (context, index) {
          final chapterNumber = index + 1;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          VersePage(book: book, chapterNumber: chapterNumber),
                ),
              );
            },
            child: Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '$chapterNumber',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blueGrey[800],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
