# TP Flutter - Gaming Tracker MN

**Nom Prénom :** Maxime Nectoux  
**Lien du dépôt Git :** https://github.com/Sneakywz/gaming_tracker_mn_flutter

---

## Présentation du projet

**Gaming Tracker MN** est une application Flutter de gestion de bibliothèque de jeux vidéo. Elle permet aux joueurs de suivre leur collection, d'enregistrer leur progression, de noter leurs jeux et de consulter des statistiques sur leur activité gaming.

### Fonctionnalités principales

L'application propose les fonctionnalités suivantes :

**Gestion de bibliothèque**
- Ajout, modification et suppression de jeux
- Informations détaillées : titre, plateforme (PS5, Xbox, PC, Switch, etc.), genre, heures jouées
- Système de notation personnelle sur 10
- Dates de début et de fin de partie
- Notes et commentaires personnels

**Suivi de progression**
- Statuts de jeu : À jouer, En cours, Terminé, Abandonné
- Chaque statut dispose d'une couleur distinctive pour une identification rapide
- Compteur d'heures jouées par jeu

**Filtrage et navigation**
- Filtres dynamiques par statut de jeu (chips interactifs)
- Navigation fluide entre les différentes pages
- Interface Material Design 3 moderne et intuitive

**Statistiques**
- Total des heures jouées sur l'ensemble de la bibliothèque
- Répartition des jeux par statut (graphique visuel)
- Identification du jeu le plus joué
- Calcul de la note moyenne attribuée
- Nombre de jeux terminés dans l'année en cours

---

## Architecture technique

### Structure du projet

Le projet suit une architecture claire et organisée :

```
lib/
├── models/
│   └── game.dart              # Modèle de données Game + enums (Platform, GameStatus)
├── providers/
│   └── game_provider.dart     # Provider pour la gestion d'état (ChangeNotifier)
├── screens/
│   ├── home_screen.dart       # Page principale avec liste et filtres
│   ├── game_detail_screen.dart # Page de détail d'un jeu
│   ├── game_form_screen.dart  # Formulaire d'ajout/édition
│   └── stats_screen.dart      # Page des statistiques
├── widgets/
│   └── game_card.dart         # Widget réutilisable pour l'affichage des jeux
└── main.dart                  # Point d'entrée de l'application
```

### Navigation et routing

L'application utilise le système de navigation Flutter avec `MaterialPageRoute` pour gérer les transitions entre les 4 écrans principaux :
1. Page d'accueil (liste des jeux)
2. Page de détail d'un jeu
3. Page de formulaire (ajout/modification)
4. Page de statistiques

### Gestion d'état avec Provider

Le pattern Provider est implémenté via `ChangeNotifier` pour assurer le partage de données entre les pages :
- **GameProvider** : Gère l'état global de la liste des jeux avec les opérations CRUD (Create, Read, Update, Delete)
- Utilisation de `Consumer` et `Provider.of` pour l'accès aux données
- Notifications automatiques des widgets lors des modifications

### Widgets utilisés

L'application fait un usage intensif des widgets natifs Flutter :
- **Layout** : Scaffold, Column, Row, Padding, Center, Expanded, SingleChildScrollView
- **Listes** : ListView.builder pour l'affichage optimisé des jeux
- **Cards** : Card, ListTile pour une présentation structurée
- **Formulaires** : TextFormField, DropdownButtonFormField, Slider, Form avec validation
- **Navigation** : AppBar, FloatingActionButton, IconButton
- **Filtres** : FilterChip pour les filtres de statut
- **Feedback** : SnackBar, AlertDialog pour les confirmations

---

## Technologies et dépendances

### Packages utilisés

```yaml
dependencies:
  flutter: sdk
  provider: ^6.1.1      # Gestion d'état
  uuid: ^4.3.3          # Génération d'IDs uniques
  intl: ^0.19.0         # Formatage des dates
```

### Compatibilité

- **Flutter SDK** : >=3.0.0 <4.0.0
- **Plateformes supportées** : Android, iOS, Web, Windows, Linux, macOS

---

## Installation et lancement

### Prérequis

- Flutter SDK installé (version 3.0 minimum)
- Un émulateur Android/iOS ou un appareil physique connecté

### Commandes

```bash
# Cloner le projet
git clone https://github.com/Sneakywz/gaming_tracker_mn_flutter.git
cd gaming_tracker_mn_flutter

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run
```

---

## État d'avancement

### Fonctionnalités implémentées

**CRUD complet**
- Création de nouveaux jeux via formulaire
- Lecture et affichage de la liste
- Mise à jour des informations
- Suppression avec confirmation

**Interface utilisateur**
- Filtres par statut avec chips interactifs
- Cartes de jeux avec informations essentielles
- Page de détail richement documentée
- Formulaire complet avec tous les champs
- Messages de confirmation (SnackBar)
- Dialogues de suppression

**Statistiques avancées**
- Total des heures jouées
- Nombre de jeux par statut
- Jeu le plus joué
- Note moyenne
- Jeux terminés cette année

**Expérience utilisateur**
- États vides gérés (messages explicites)
- Icônes et couleurs cohérentes par statut
- Transitions fluides entre pages
- Feedback visuel sur toutes les actions

---


## Améliorations possibles (hors scope du TP)

Fonctionnalités qui pourraient être ajoutées dans une version future :

- **Persistance des données** : Intégration de Hive ou SQLite pour sauvegarder localement
- **Recherche** : Barre de recherche pour filtrer par nom de jeu
- **Tri avancé** : Options de tri par note, heures jouées, date d'ajout
- **Images** : Ajout de pochettes de jeux
- **Graphiques** : Visualisation des statistiques avec charts
- **Thème sombre** : Mode sombre/clair
- **Export/Import** : Sauvegarde et restauration de la bibliothèque
- **API externe** : Intégration avec IGDB pour récupérer automatiquement les infos
- **Objectifs** : Système de défis et badges

---

## Conclusion

L'application **Gaming Tracker MN** répond à l'ensemble des critères du TP Flutter et démontre une bonne maîtrise des concepts fondamentaux du framework. Le projet est fonctionnel, bien structuré, et prêt à être utilisé ou étendu avec de nouvelles fonctionnalités.

Le code source complet est disponible sur le dépôt GitHub : https://github.com/Sneakywz/gaming_tracker_mn_flutter

---

**Date de rendu :** 09/01/26
**Module :** Développement Mobile - Flutter  
**Établissement :** ESGI - 2ème année