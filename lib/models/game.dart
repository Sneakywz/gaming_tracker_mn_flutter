import 'package:uuid/uuid.dart';

enum GameStatus {
  backlog('À jouer', 0xFFFF9800), // Orange
  playing('En cours', 0xFF2196F3), // Bleu
  completed('Terminé', 0xFF4CAF50), // Vert
  dropped('Abandonné', 0xFFF44336); // Rouge

  final String label;
  final int color;
  const GameStatus(this.label, this.color);
}

enum Platform {
  ps5('PlayStation 5'),
  ps4('PlayStation 4'),
  xbox('Xbox Series X/S'),
  xboxOne('Xbox One'),
  pc('PC'),
  nintendo('Nintendo Switch'),
  mobile('Mobile'),
  other('Autre');

  final String label;
  const Platform(this.label);
}

class Game {
  final String id;
  final String title;
  final Platform platform;
  final String genre;
  final int hoursPlayed;
  final GameStatus status;
  final double rating; // Note sur 10
  final DateTime? startedDate;
  final DateTime? completedDate;
  final String notes;

  Game({
    String? id,
    required this.title,
    required this.platform,
    this.genre = '',
    this.hoursPlayed = 0,
    this.status = GameStatus.backlog,
    this.rating = 0.0,
    this.startedDate,
    this.completedDate,
    this.notes = '',
  }) : id = id ?? const Uuid().v4();

  // Copie avec modifications
  Game copyWith({
    String? title,
    Platform? platform,
    String? genre,
    int? hoursPlayed,
    GameStatus? status,
    double? rating,
    DateTime? startedDate,
    DateTime? completedDate,
    String? notes,
  }) {
    return Game(
      id: id,
      title: title ?? this.title,
      platform: platform ?? this.platform,
      genre: genre ?? this.genre,
      hoursPlayed: hoursPlayed ?? this.hoursPlayed,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      startedDate: startedDate ?? this.startedDate,
      completedDate: completedDate ?? this.completedDate,
      notes: notes ?? this.notes,
    );
  }
}