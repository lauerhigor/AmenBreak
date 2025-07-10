import 'package:flutter/material.dart';
import 'package:myapp/models/model.dart';
import 'package:myapp/pages/study_page.dart'; // Importa a nova página de estudo
import 'package:myapp/services/openai_service.dart'; // Importa o serviço da OpenAI

class VersePage extends StatefulWidget {
  final Book book;
  final int chapterNumber;

  const VersePage({Key? key, required this.book, required this.chapterNumber})
    : super(key: key);

  @override
  _VersePageState createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
  final OpenAIService _openAIService = OpenAIService();
  bool _isGeneratingStudy = false;

  final List<String> _mockVerses = [
    "No princípio, criou Deus os céus e a terra.",
    "A terra, porém, estava sem forma e vazia; havia trevas sobre a face do abismo, e o Espírito de Deus pairava por sobre as águas.",
    "Disse Deus: Haja luz; e houve luz.",
    "E viu Deus que a luz era boa; e fez separação entre a luz e as trevas.",
    "Chamou Deus à luz Dia e às trevas, Noite. Houve tarde e manhã, o primeiro dia.",
    "E então teve início a segunda guerra mundial, após o assassinato do Duque Franz Ferdinand",
  ];

  // Função para exibir um diálogo de erro
  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Erro ao Gerar Estudo'),
            content: Text(
              'Ocorreu um erro ao comunicar com a IA. Verifique sua chave de API no arquivo .env e sua conexão com a internet.\n\nDetalhes: $error',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  Future<void> _handleVerseTap(String verseText) async {
    setState(() {
      _isGeneratingStudy = true;
    });

    try {
      print('--- GERANDO ESTUDO PARA: "$verseText" ---');
      final studyText = await _openAIService.generateStudy(verseText);
      print('--- ESTUDO GERADO COM SUCESSO ---');

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => StudyPage(verse: verseText, studyText: studyText),
          ),
        );
      }
    } catch (e) {
      // Em caso de erro, exibe o diálogo
      print('--- ERRO AO GERAR ESTUDO ---');
      print(e.toString());
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGeneratingStudy = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          '${widget.book.name} ${widget.chapterNumber}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _mockVerses.length,
            itemBuilder: (context, index) {
              final verseNumber = index + 1;
              final verseContent = _mockVerses[index];
              // Monta o texto completo do versículo para enviar à IA
              final fullVerseText =
                  '${widget.book.name} ${widget.chapterNumber}:$verseNumber - "$verseContent"';

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap:
                      _isGeneratingStudy
                          ? null
                          : () => _handleVerseTap(fullVerseText),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$verseNumber',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey[700],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            verseContent,
                            style: const TextStyle(fontSize: 17, height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          if (_isGeneratingStudy)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Colors.white),
                    SizedBox(height: 16),
                    Text(
                      'Analisando o versículo...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
