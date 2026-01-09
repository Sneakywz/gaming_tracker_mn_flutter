import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../providers/game_provider.dart';

class GameFormScreen extends StatefulWidget {
  final Game? game; // null si ajout, Game si édition

  const GameFormScreen({super.key, this.game});

  @override
  State<GameFormScreen> createState() => _GameFormScreenState();
}

class _GameFormScreenState extends State<GameFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _genreController;
  late TextEditingController _hoursController;
  late TextEditingController _notesController;

  late Platform _selectedPlatform;
  late GameStatus _selectedStatus;
  double _rating = 0.0;
  DateTime? _startedDate;
  DateTime? _completedDate;

  @override
  void initState() {
    super.initState();
    // Si édition, pré-remplir les champs
    if (widget.game != null) {
      _titleController = TextEditingController(text: widget.game!.title);
      _genreController = TextEditingController(text: widget.game!.genre);
      _hoursController =
          TextEditingController(text: widget.game!.hoursPlayed.toString());
      _notesController = TextEditingController(text: widget.game!.notes);
      _selectedPlatform = widget.game!.platform;
      _selectedStatus = widget.game!.status;
      _rating = widget.game!.rating;
      _startedDate = widget.game!.startedDate;
      _completedDate = widget.game!.completedDate;
    } else {
      _titleController = TextEditingController();
      _genreController = TextEditingController();
      _hoursController = TextEditingController(text: '0');
      _notesController = TextEditingController();
      _selectedPlatform = Platform.pc;
      _selectedStatus = GameStatus.backlog;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _genreController.dispose();
    _hoursController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.game != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier le jeu' : 'Ajouter un jeu'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Titre
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titre du jeu *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.videogame_asset),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Le titre est obligatoire';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Plateforme
            DropdownButtonFormField<Platform>(
              value: _selectedPlatform,
              decoration: const InputDecoration(
                labelText: 'Plateforme',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.devices),
              ),
              items: Platform.values.map((platform) {
                return DropdownMenuItem(
                  value: platform,
                  child: Text(platform.label),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPlatform = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Genre
            TextFormField(
              controller: _genreController,
              decoration: const InputDecoration(
                labelText: 'Genre',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category),
                hintText: 'RPG, Action, Aventure...',
              ),
            ),
            const SizedBox(height: 16),

            // Statut
            DropdownButtonFormField<GameStatus>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Statut',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.flag),
              ),
              items: GameStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Color(status.color),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(status.label),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Heures jouées
            TextFormField(
              controller: _hoursController,
              decoration: const InputDecoration(
                labelText: 'Heures jouées',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.schedule),
                suffixText: 'h',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value != null &&
                    value.isNotEmpty &&
                    int.tryParse(value) == null) {
                  return 'Nombre invalide';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Note
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ma note : ${_rating.toStringAsFixed(1)}/10',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: _rating,
                      min: 0,
                      max: 10,
                      divisions: 20,
                      label: _rating.toStringAsFixed(1),
                      onChanged: (value) {
                        setState(() {
                          _rating = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Dates
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Dates',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: const Icon(Icons.play_arrow),
                      title: const Text('Date de début'),
                      subtitle: Text(_startedDate != null
                          ? '${_startedDate!.day}/${_startedDate!.month}/${_startedDate!.year}'
                          : 'Non définie'),
                      trailing: IconButton(
                        icon: Icon(_startedDate != null
                            ? Icons.edit
                            : Icons.add),
                        onPressed: () => _selectDate(context, true),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.check_circle),
                      title: const Text('Date de fin'),
                      subtitle: Text(_completedDate != null
                          ? '${_completedDate!.day}/${_completedDate!.month}/${_completedDate!.year}'
                          : 'Non définie'),
                      trailing: IconButton(
                        icon: Icon(_completedDate != null
                            ? Icons.edit
                            : Icons.add),
                        onPressed: () => _selectDate(context, false),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Notes
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Mes notes / commentaires',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.notes),
                hintText: 'Mes impressions...',
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 24),

            // Bouton sauvegarder
            ElevatedButton.icon(
              onPressed: _saveGame,
              icon: const Icon(Icons.save),
              label: Text(isEditing ? 'Enregistrer' : 'Ajouter'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startedDate = picked;
        } else {
          _completedDate = picked;
        }
      });
    }
  }

  void _saveGame() {
    if (_formKey.currentState!.validate()) {
      final gameProvider = Provider.of<GameProvider>(context, listen: false);

      final game = Game(
        id: widget.game?.id,
        title: _titleController.text.trim(),
        platform: _selectedPlatform,
        genre: _genreController.text.trim(),
        hoursPlayed: int.tryParse(_hoursController.text) ?? 0,
        status: _selectedStatus,
        rating: _rating,
        startedDate: _startedDate,
        completedDate: _completedDate,
        notes: _notesController.text.trim(),
      );

      if (widget.game == null) {
        gameProvider.addGame(game);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jeu ajouté !')),
        );
      } else {
        gameProvider.updateGame(game);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Jeu mis à jour !')),
        );
      }

      Navigator.pop(context);
    }
  }
}