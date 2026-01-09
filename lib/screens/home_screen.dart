import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../providers/game_provider.dart';
import '../widgets/game_card.dart';
import 'game_form_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GameStatus? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Bibliothèque de Jeux'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StatsScreen()),
              );
            },
            tooltip: 'Statistiques',
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtres
          _buildFilterChips(),
          // Liste des jeux
          Expanded(
            child: _buildGameList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const GameFormScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Ajouter un jeu'),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            FilterChip(
              label: const Text('Tous'),
              selected: _selectedFilter == null,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = null;
                });
              },
            ),
            const SizedBox(width: 8),
            ...GameStatus.values.map((status) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(status.label),
                  selected: _selectedFilter == status,
                  onSelected: (selected) {
                    setState(() {
                      _selectedFilter = selected ? status : null;
                    });
                  },
                  backgroundColor: Color(status.color).withOpacity(0.1),
                  selectedColor: Color(status.color).withOpacity(0.3),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildGameList() {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        final games = gameProvider.getGamesByStatus(_selectedFilter);

        if (games.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.videogame_asset_off,
                  size: 80,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  _selectedFilter == null
                      ? 'Aucun jeu dans ta bibliothèque'
                      : 'Aucun jeu avec ce statut',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Appuie sur + pour en ajouter',
                  style: TextStyle(color: Colors.grey[500]),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: games.length,
          itemBuilder: (context, index) {
            return GameCard(game: games[index]);
          },
        );
      },
    );
  }
}