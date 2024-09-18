import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');
  final CollectionReference bookmarks =
      FirebaseFirestore.instance.collection('bookmarks');

  Future<QuerySnapshot> getBookmarks() async {
    // Replace 'bookmarks' with the actual collection name if different
    return await bookmarks.get();
  }

  Future<QuerySnapshot> getFavorites() async {
    print('firebase retrieve favorite');
    // Replace 'bookmarks' with the actual collection name if different
    return await favorites.get();
  }

  //  bookmark news item
  Future<void> addBookmark(
      String title, String imageurl, String newsurl, String description) async {
    await bookmarks.add({
      'title': title,
      'description': description,
      'imageurl': imageurl,
      'newsurl': newsurl,
      'isBookmark': true, // Mark it as favorite
    });
  }

  Future<void> removeBookmark(String title, String description) async {
    QuerySnapshot querySnapshot = await bookmarks
        .where('title', isEqualTo: title)
        .where('description', isEqualTo: description)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  // Check if a news item is favorited
  Future<bool> isNewsBookmarks(String title, String description) async {
    QuerySnapshot querySnapshot = await bookmarks
        .where('title', isEqualTo: title)
        .where('description', isEqualTo: description)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  // Add favorite news item
  Future<void> addFavorite(
      String title, String imageurl, String newsurl, String description) async {
    await favorites.add({
      'title': title,
      'description': description,
      'imageurl': imageurl,
      'newsurl': newsurl,
      'isFavorite': true, // Mark it as favorite
    });
  }

  // Remove favorite news item
  Future<void> removeFavorite(String title, String description) async {
    QuerySnapshot querySnapshot = await favorites
        .where('title', isEqualTo: title)
        .where('description', isEqualTo: description)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  // Check if a news item is favorited
  Future<bool> isNewsFavorite(String title, String description) async {
    QuerySnapshot querySnapshot = await favorites
        .where('title', isEqualTo: title)
        .where('description', isEqualTo: description)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}
