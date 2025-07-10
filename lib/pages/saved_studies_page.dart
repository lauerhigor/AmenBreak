import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // Para formatar a data
import 'package:myapp/models/study_model.dart';
import 'package:myapp/pages/study_page.dart';

class SavedStudiesPage extends StatefulWidget {
  const SavedStudiesPage({Key? key}) : super(key: key);

  @override
  _SavedStudiesPageState createState() => _SavedStudiesPageState();
}

class _SavedStudiesPageState extends State<SavedStudiesPage> {
  final _currentUser = FirebaseAuth.instance.currentUser;

  Stream<List<Study>> _getSavedStudiesStream() {
    if (_currentUser == null) {
      // Retorna um stream vazio se o usuário não estiver logado
      return Stream.value([]);
    }

    // Caminho para a subcoleção de estudos do usuário
    final collectionPath = 'studies/${_currentUser.uid}/user_studies';

    return FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy('createdAt', descending: true) // Ordena pelos mais recentes
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Study.fromSnapshot(doc)).toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Meus Estudos Salvos'),
        backgroundColor: Colors.blueGrey[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<List<Study>>(
        stream: _getSavedStudiesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.blueGrey[900]),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar estudos: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Nenhum estudo salvo ainda.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final studies = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: studies.length,
            itemBuilder: (context, index) {
              final study = studies[index];
              // Formata a data para um formato legível
              final formattedDate = DateFormat(
                'dd/MM/yyyy \'às\' HH:mm',
              ).format(study.createdAt.toDate());

              return Card(
                elevation: 3.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 20.0,
                  ),
                  title: Text(
                    study.verse,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Salvo em: $formattedDate'),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // --- DEBUGGING ---
                    // Adicionamos prints para verificar se o toque é registrado e os dados estão corretos.
                    print('--- TENTANDO NAVEGAR ---');
                    print('Versículo: ${study.verse}');
                    print('Texto do Estudo: ${study.studyText}');

                    try {
                      // Reutiliza a StudyPage para exibir o conteúdo completo
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => StudyPage(
                                verse: study.verse,
                                studyText: study.studyText,
                              ),
                        ),
                      );
                      print('--- NAVEGAÇÃO CHAMADA COM SUCESSO ---');
                    } catch (e) {
                      print('--- ERRO DURANTE A NAVEGAÇÃO ---');
                      print(e.toString());
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
