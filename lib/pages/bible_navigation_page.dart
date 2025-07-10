import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/models/model.dart';
import 'package:myapp/pages/login_page.dart';
import 'package:myapp/pages/chapter_verse_page.dart';
import 'package:myapp/pages/saved_studies_page.dart'; // Importa a página de estudos salvos

// --- SERVICES ---
class BibleService {
  Future<List<Book>> getBooks() async {
    await Future.delayed(const Duration(seconds: 1));
    print("INFO: Carregando dados MOCK.");
    return [
      Book(name: 'Gênesis', ref: 'Gen', chaptersCount: 50),
      Book(name: 'Êxodo', ref: 'Exo', chaptersCount: 40),
      Book(name: 'Levítico', ref: 'Lev', chaptersCount: 27),
      Book(name: 'Números', ref: 'Num', chaptersCount: 36),
      Book(name: 'Deuteronômio', ref: 'Deut', chaptersCount: 34),
      Book(name: 'Mateus', ref: 'Matt', chaptersCount: 28),
      Book(name: 'Marcos', ref: 'Mark', chaptersCount: 16),
      Book(name: 'Lucas', ref: 'Luke', chaptersCount: 24),
      Book(name: 'João', ref: 'John', chaptersCount: 21),
    ];
  }
}

// --- PÁGINA DE NAVEGAÇÃO DOS LIVROS ---
class BibleNavigationPage extends StatefulWidget {
  const BibleNavigationPage({Key? key}) : super(key: key);

  @override
  _BibleNavigationPageState createState() => _BibleNavigationPageState();
}

class _BibleNavigationPageState extends State<BibleNavigationPage> {
  late final Future<List<Book>> _booksFuture;
  final BibleService _bibleService = BibleService();

  @override
  void initState() {
    super.initState();
    _booksFuture = _bibleService.getBooks();
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Bíblia Sagrada',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.blueGrey[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark, color: Colors.white),
            tooltip: 'Estudos Salvos',
            onPressed: () {
              // CORREÇÃO: Adicionada a navegação para a página de estudos salvos.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SavedStudiesPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Sair',
            onPressed: _logout,
          ),
        ],
      ),
      body: FutureBuilder<List<Book>>(
        future: _booksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.blueGrey[900]),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Erro ao carregar: ${snapshot.error}'),
              ),
            );
          }
          if (snapshot.hasData) {
            final books = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 12.0,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  elevation: 3.0,
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 20.0,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey[800],
                      child: const Icon(
                        Icons.menu_book,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    title: Text(
                      book.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text('${book.chaptersCount} capítulos'),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChapterVersePage(book: book),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Nenhum livro encontrado.'));
        },
      ),
    );
  }
}
