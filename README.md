# Diário de Estudos Bíblicos + IA

## Sobre o Projeto

Este é um aplicativo móvel desenvolvido em Flutter como projeto final da disciplina de Programação Mobile 2 no Instituto Federal de Rondônia (IFRO). O objetivo é fornecer uma ferramenta para que os utilizadores possam navegar pela Bíblia, selecionar versículos e receber um estudo aprofundado gerado por Inteligência Artificial, com a opção de salvar esses estudos para consulta futura.

O projeto integra as seguintes tecnologias:
- **Flutter** para a interface do utilizador
- **Firebase Authentication** para gestão de contas de utilizador
- **Cloud Firestore** para armazenamento de dados (estudos salvos)
- **API da OpenAI** (GPT-3.5-turbo) para a geração de estudos bíblicos
- **API da Bible4U** (simulada com dados locais) para o conteúdo bíblico
- **WebView** para exibir links externos

---

## Funcionalidades Implementadas

- ✅ **Autenticação de Utilizador:** Login e criação de conta com e-mail e senha.
- ✅ **Navegação Bíblica:** Ecrãs para listar livros, selecionar capítulos e visualizar versículos.
- ✅ **Geração de Estudos com IA:** Ao tocar num versículo, é gerado um estudo detalhado contendo:
    - Contexto Histórico
    - Aplicação Prática
    - Referências Cruzadas
- ✅ **Biblioteca Pessoal:** Os utilizadores podem salvar os estudos gerados numa coleção pessoal no Firestore.
- ✅ **Visualização de Estudos Salvos:** Um ecrã dedicado para listar e reler todos os estudos guardados.
- ✅ **Visualização de Links Externos:** Se a IA fornecer um link para um artigo de apoio, este pode ser aberto dentro da aplicação através de uma WebView.
- ✅ **Segurança:** As regras do Firestore garantem que cada utilizador só pode aceder aos seus próprios estudos.

---

## Capturas de tela


---

## Como Configurar e Rodar o Projeto

Siga os passos abaixo para configurar e executar o projeto localmente.

### 1. Pré-requisitos

- Ter o [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado.
- Ter um editor de código como o [VS Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio).
- Ter um emulador Android ou iOS configurado, ou um dispositivo físico.

### 2. Clonar o Repositório

```bash
git clone [URL_DO_SEU_REPOSITORIO_AQUI]
cd [NOME_DA_PASTA_DO_PROJETO]
```

### 3. Instalar Dependências

Execute o seguinte comando para instalar todos os pacotes necessários:

```bash
flutter pub get
```

### 4. Configuração do Firebase

Este projeto utiliza o Firebase. É necessário conectá-lo ao seu próprio projeto Firebase.

- Instale a Firebase CLI se ainda não o tiver feito.
- Execute o seguinte comando e siga as instruções para selecionar as plataformas (Android/iOS) e o seu projeto Firebase:

```bash
flutterfire configure
```

Este comando irá gerar o ficheiro `lib/firebase_options.dart` automaticamente.

### 5. Configuração das Variáveis de Ambiente (API da OpenAI)

A chave da API da OpenAI é carregada a partir de um ficheiro de ambiente para segurança.

- Na raiz do projeto, crie um ficheiro chamado `.env`.
- Dentro do ficheiro `.env`, adicione a sua chave da API da OpenAI da seguinte forma:

```
OPENAI_API_KEY=sk-sua-chave-secreta-aqui
```

**Importante:** Certifique-se de que o ficheiro `pubspec.yaml` inclui o `.env` na secção de `assets`:
```yaml
flutter:
  assets:
    - .env
```

### 6. Executar a Aplicação

Com tudo configurado, execute a aplicação com o seguinte comando:

```bash
flutter run

![alt text](image.png)