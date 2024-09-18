import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_project/Network/firebase_service.dart';

class NewsActionProvider with ChangeNotifier {
  final FirebaseService firebaseService = FirebaseService();

  // A map to store favorite status for each news item using title and description as key
  final Map<String, bool> _favorites = {};
  final Map<String, bool> _bookmark = {};

  List<DocumentSnapshot> _bookmarkedDocuments = [];
  List<DocumentSnapshot> _favoriteDocuments = [];

  bool _isLoadingBookmarks = false;
  bool _isLoadingFavorites = false;

  List<DocumentSnapshot> get bookmarkedDocuments => _bookmarkedDocuments;
  List<DocumentSnapshot> get favoriteDocuments => _favoriteDocuments;
  bool get isLoadingBookmarks => _isLoadingBookmarks;
  bool get isLoadingFavorites => _isLoadingFavorites;

  Future<void> getBookmark() async {
    _isLoadingBookmarks = true;
    notifyListeners();

    try {
      QuerySnapshot querySnapshot = await firebaseService.getBookmarks();
      _bookmarkedDocuments = querySnapshot.docs;
      print('got bookmarks');
      // Populate the bookmark map based on fetched documents
      for (var doc in _bookmarkedDocuments) {
        String title = doc['title'];
        String description = doc['description'];
        String key = '$title-$description';
        _bookmark[key] = true; // Set true for all fetched bookmarks
      }
    } catch (e) {
      // Handle errors
    } finally {
      _isLoadingBookmarks = false;
      notifyListeners();
    }
  }

  Future<void> getFavorite() async {
    _isLoadingFavorites = true;
    notifyListeners();

    try {
      QuerySnapshot querySnapshot = await firebaseService.getFavorites();
      _favoriteDocuments = querySnapshot.docs;
      print('getting favorites');
      // Populate the bookmark map based on fetched documents
      for (var doc in _favoriteDocuments) {
        String title = doc['title'];
        String description = doc['description'];
        String key = '$title-$description';
        _favorites[key] = true; // Set true for all fetched bookmarks
      }
    } catch (e) {
      // Handle errors
    } finally {
      _isLoadingFavorites = false;
      notifyListeners();
    }
  }

  bool isFavorite(String title, String description) {
    String key = '$title-$description';
    return _favorites[key] ?? false;
  }

  bool isbookmark(String title, String description) {
    String key = '$title-$description';
    return _bookmark[key] ?? false;
  }

  Future<void> toggleBookmark(
      String title, String imageurl, String newsurl, String description) async {
    String key = '$title-$description';
    bool currentBookmarkStatus = _bookmark[key] ?? false;

    if (currentBookmarkStatus) {
      // If currently favorited, remove from favorites
      await firebaseService.removeBookmark(title, description);
      _bookmarkedDocuments.removeWhere(
          (doc) => doc['title'] == title && doc['description'] == description);
    } else {
      // If not favorited, add to favorites
      await firebaseService.addBookmark(title, imageurl, newsurl, description);
    }

    // Toggle the favorite status in the map
    _bookmark[key] = !currentBookmarkStatus;

    notifyListeners(); // Notify the UI to update
  }

  Future<void> toggleFavorite(
      String title, String imageurl, String newsurl, String description) async {
    String key = '$title-$description';
    bool currentFavoriteStatus = _favorites[key] ?? false;

    if (currentFavoriteStatus) {
      // If currently favorited, remove from favorites
      await firebaseService.removeFavorite(title, description);
      _favoriteDocuments.removeWhere(
          (doc) => doc['title'] == title && doc['description'] == description);
    } else {
      // If not favorited, add to favorites
      await firebaseService.addFavorite(title, imageurl, newsurl, description);
    }

    // Toggle the favorite status in the map
    _favorites[key] = !currentFavoriteStatus;

    notifyListeners(); // Notify the UI to update
  }
}
