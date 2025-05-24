# 📚 Gestionnaire de Livres - Application Flutter

## 📝 Description du Projet
Ce projet a été développé dans le cadre du cours de développement mobile utilisant Flutter. L'application permet aux utilisateurs de rechercher des livres via l'API Google Books et de gérer leur bibliothèque personnelle.

## 🎯 Objectifs Pédagogiques
- Maîtriser le développement d'applications mobiles avec Flutter
- Comprendre l'intégration d'APIs externes (Google Books API)
- Implémenter la gestion locale des données avec SQLite
- Développer une interface utilisateur moderne et responsive
- Gérer l'état de l'application et les interactions utilisateur

## 🛠 Fonctionnalités Principales

### 1. Recherche de Livres
- Interface de recherche intuitive
- Résultats en temps réel
- Affichage des couvertures et informations détaillées
- Gestion des erreurs et états de chargement

### 2. Gestion des Favoris
- Ajout/Suppression de livres aux favoris
- Stockage local des favoris
- Synchronisation avec la base de données SQLite
- Interface dédiée pour la gestion des favoris

### 3. Interface Utilisateur
- Design moderne et épuré
- Animations fluides
- Adaptation automatique à différentes tailles d'écran
- Thème personnalisé et cohérent

## 💻 Aspects Techniques

### Architecture
- Structure MVC (Modèle-Vue-Contrôleur)
- Séparation claire des responsabilités
- Code modulaire et réutilisable

### Technologies Utilisées
- Flutter SDK
- Dart
- SQLite pour le stockage local
- HTTP pour les requêtes API
- Git pour le versioning

### Packages Principaux
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.4.0
  sqflite: ^2.4.2
  path: ^1.9.1
```

## 📱 Captures d'Écran
[À ajouter : captures d'écran de l'application]

## 🚀 Installation et Démarrage

1. **Prérequis**
   - Flutter SDK
   - Dart SDK
   - Un éditeur de code (VS Code recommandé)
   - Git

2. **Installation**
   ```bash
   # Cloner le dépôt
   git clone [URL_DU_REPO]

   # Accéder au répertoire
   cd [NOM_DU_DOSSIER]

   # Installer les dépendances
   flutter pub get

   # Lancer l'application
   flutter run
   ```

## 🔧 Configuration
- Aucune configuration supplémentaire n'est requise
- L'application fonctionne directement après l'installation

## 📚 Structure du Projet
```
lib/
  ├── models/
  │   └── book.dart
  ├── pages/
  │   ├── homepage.dart
  │   ├── detailpage.dart
  │   └── favoritespage.dart
  ├── services/
  │   ├── api_service.dart
  │   └── db_service.dart
  └── main.dart
```

## 🤝 Contribution au Projet
Ce projet a été développé dans un cadre éducatif. Les contributions et suggestions sont les bienvenues pour améliorer l'application.

## 📝 Notes de Développement
- L'application utilise une architecture simple mais efficace
- Le code est commenté pour faciliter la compréhension
- Les bonnes pratiques de Flutter ont été suivies
- L'interface utilisateur est optimisée pour une expérience fluide

## ✨ Améliorations Futures Possibles
1. Ajout de catégories de livres
2. Système de notation personnelle
3. Partage de livres via les réseaux sociaux
4. Mode hors ligne amélioré
5. Synchronisation cloud des favoris


## 📄 Licence
Ce projet est réalisé dans le cadre d'un cours et est soumis aux règles de propriété intellectuelle de l'établissement.

---

### 📊 Évaluation du Projet
Ce projet sera évalué sur les critères suivants :
- Qualité du code et architecture
- Fonctionnalités implémentées
- Interface utilisateur et expérience utilisateur
- Gestion des données et des états
- Documentation et présentation

### 🎓 Contexte Académique
Ce projet fait partie du module de développement mobile et représente une application pratique des concepts appris en cours.
