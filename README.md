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

![image](https://github.com/user-attachments/assets/d061c8b2-af00-4c08-8392-d3a79ab897c4)
![image](https://github.com/user-attachments/assets/57abd988-9b55-474c-9cca-4cb78bb005a1)
![image](https://github.com/user-attachments/assets/59b1ecbc-f069-45eb-9783-b61646824435)
![image](https://github.com/user-attachments/assets/18551886-6075-4c23-ac80-c77ed68d84e7)
![image](https://github.com/user-attachments/assets/33e3f9af-2776-481f-b799-ecebae0465fc)
![image](https://github.com/user-attachments/assets/d1193c1a-cfd0-4129-975e-2997d22b7a17)
![image](https://github.com/user-attachments/assets/3167962c-30ce-4fa6-837c-193dfae4c78c)
![image](https://github.com/user-attachments/assets/73c58ca6-9bc3-4352-9ae6-6275a2ad7a3d)
![image](https://github.com/user-attachments/assets/67b99133-9caa-4ab2-b5f5-198cd8d3946f)
![image](https://github.com/user-attachments/assets/839aadb8-c4b2-4acd-9989-89237dc93b19)





