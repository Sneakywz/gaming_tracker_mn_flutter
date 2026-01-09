import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../providers/game_provider.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Statistiques'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          final totalHours = gameProvider.getTotalHours();
          final countByStatus = gameProvider.getCountByStatus();
          final mostPlayed = gameProvider.getMostPlayedGame();
          final avgRating = gameProvider.getAverageRating();
          final completedThisYear = gameProvider.getCompletedThisYear();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Carte principale
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.videogame_asset,
                        size: 60,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '$totalHours heures',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const Text(
                        'de jeu au total',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Stats par statut
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Répartition des jeux',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      ...GameStatus.values.map((status) {
                        final count = countByStatus[status] ?? 0;
                        return _buildStatusRow(status, count);
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Jeu le plus joué
              if (mostPlayed != null)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.emoji_events, color: Colors.amber),
                    title: const Text('Jeu le plus joué'),
                    subtitle: Text(mostPlayed.title),
                    trailing: Text(
                      '${mostPlayed.hoursPlayed}h',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Moyenne des notes
              if (avgRating > 0)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.star, color: Colors.orange),
                    title: const Text('Note moyenne'),
                    trailing: Text(
                      '${avgRating.toStringAsFixed(1)}/10',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),

              // Jeux terminés cette année
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today, color: Colors.green),
                  title: Text('Jeux terminés en ${DateTime.now().year}'),
                  trailing: Text(
                    '$completedThisYear',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusRow(GameStatus status, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Color(status.color),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(status.label),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Color(status.color).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(status.color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}