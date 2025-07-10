import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  final String? _apiKey = dotenv.env['OPENAI_API_KEY'];

  Future<String> generateStudy(String verse) async {
    if (_apiKey == null) {
      throw Exception(
        'Chave da API da OpenAI não encontrada. Verifique seu arquivo .env',
      );
    }

    final url = Uri.parse('https://api.openai.com/v1/chat/completions');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    };

    // ATUALIZAÇÃO: Adicionamos uma seção "Para Saber Mais" no prompt.
    final prompt = """
    Gere um estudo bíblico conciso para o seguinte versículo: "$verse".
    O estudo deve ter no máximo 500 tokens e ser dividido EXATAMENTE nas seguintes seções, com os títulos em negrito:

    **Contexto Histórico:**
    [Análise do contexto histórico, cultural e literário do versículo]

    **Aplicação Prática:**
    [Como este versículo pode ser aplicado na vida diária do leitor moderno]

    **Referências Cruzadas:**
    [Liste 2-3 outros versículos da Bíblia que se conectam ou expandem o tema deste versículo, formatando como "Livro Capítulo:Versículo"]
    
    **Para Saber Mais:**
    [Se encontrar um artigo, estudo ou vídeo online de alta qualidade que aprofunde o tema, inclua a URL completa aqui. Se não encontrar, escreva "Nenhum link recomendado." e deixe um link para o clipe de never gonna give you up.]
    """;

    final body = jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
      'max_tokens': 500,
      'temperature': 0.5,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'].trim();
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(
          'Falha ao gerar estudo: ${response.statusCode} - ${errorBody['error']['message']}',
        );
      }
    } catch (e) {
      throw Exception('Erro ao conectar com a API da OpenAI: $e');
    }
  }
}
