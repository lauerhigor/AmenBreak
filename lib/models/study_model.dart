import 'package:cloud_firestore/cloud_firestore.dart';

// Modelo para representar um documento de estudo do Firestore
class Study {
  final String id;
  final String verse;
  final String studyText;
  final Timestamp createdAt;

  Study({
    required this.id,
    required this.verse,
    required this.studyText,
    required this.createdAt,
  });

  // Factory para criar uma instância de Study a partir de um DocumentSnapshot do Firestore
  factory Study.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Study(
      id: doc.id,
      verse: data['verse'] ?? 'Versículo não encontrado',
      studyText: data['studyText'] ?? 'Estudo não encontrado',
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}
