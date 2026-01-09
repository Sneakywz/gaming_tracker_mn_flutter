import 'package:flutter/foundation.dart';
import '../models/game.dart';

class GameProvider extends ChangeNotifier {
  final List<Game> _games = [
    // Quelques jeux d'exemple pour tester
    Game(
      title: 'The Legend of Zelda: Tears of the Kingdom',
      platform: Platform.nintendo,
      genre: 'Action-Aventure',
      hoursPlayed: 85,
      status: GameStatus.completed,
      rating: 10.0,
      startedDate: DateTime(2024, 5, 12),
      completedDate: DateTime(2024, 7, 8),
      notes: 'Chef-d\'œuvre absolu ! Les mécaniques de construction sont géniales.',
    ),
    Game(
      title: 'Elden Ring',
      platform: Platform.ps5,
      genre: 'Action-RPG',
      hoursPlayed: 42,
      status: GameStatus.playing,
      rating: 9.5,
      startedDate: DateTime(2024, 11, 1),
      notes: 'Difficile mais passionnant',
    ),
    Game(
      title: 'Baldur\'s Gate 3',
      platform: Platform.pc,
      genre: 'RPG',
      hoursPlayed: 0,
      status: GameStatus.backlog,
      rating: 0.0,
      notes: 'J\'ai hâte de commencer !',
    ),
  ];

  List<Game> get games => List.unmodifiable(_games);

  // Filtrer par statut
  List<Game> getGamesByStatus(GameStatus? status) {
    if (status == null) return games;
    return _games.where((game) => game.status == status).toList();
  }

  // Ajouter un jeu
  void addGame(Game game) {
    _games.add(game);
    notifyListeners();
  }

  // Mettre à jour un jeu
  void updateGame(Game updatedGame) {
    final index = _games.indexWhere((game) => game.id == updatedGame.id);
    if (index != -1) {
      _games[index] = updatedGame;
      notifyListeners();
    }
  }

  // Supprimer un jeu
  void deleteGame(String id) {
    _games.removeWhere((game) => game.id == id);
    notifyListeners();
  }

  // Récupérer un jeu par ID
  Game? getGameById(String id) {
    try {
      return _games.firstWhere((game) => game.id == id);
    } catch (e) {
      return null;
    }
  }

  // === STATISTIQUES ===

  // Total heures jouées
  int getTotalHours() {
    return _games.fold(0, (sum, game) => sum + game.hoursPlayed);
  }

  // Nombre de jeux par statut
  Map<GameStatus, int> getCountByStatus() {
    final Map<GameStatus, int> counts = {};
    for (var status in GameStatus.values) {
      counts[status] = _games.where((game) => game.status == status).length;
    }
    return counts;
  }

  // Jeu le plus joué
  Game? getMostPlayedGame() {
    if (_games.isEmpty) return null;
    return _games.reduce((a, b) => a.hoursPlayed > b.hoursPlayed ? a : b);
  }

  // Moyenne de note
  double getAverageRating() {
    final ratedGames = _games.where((game) => game.rating > 0).toList();
    if (ratedGames.isEmpty) return 0.0;
    final sum = ratedGames.fold(0.0, (sum, game) => sum + game.rating);
    return sum / ratedGames.length;
  }

  // Jeux terminés cette année
  int getCompletedThisYear() {
    final currentYear = DateTime.now().year;
    return _games
        .where((game) =>
            game.status == GameStatus.completed &&
            game.completedDate != null &&
            game.completedDate!.year == currentYear)
        .length;
  }
}