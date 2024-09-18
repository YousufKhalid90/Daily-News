import 'package:flutter/material.dart';
import 'package:news_project/Provider/newsaction_provider.dart';
import 'package:provider/provider.dart';

import '../Components/nav_drawer.dart';
import '../Components/news_card.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({super.key});

  @override
  State<Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NewsActionProvider>(context, listen: false).getBookmark();
    });
    // Fetch bookmarks if not already fetched
  }

  @override
  Widget build(BuildContext context) {
    final newsActionProvider = Provider.of<NewsActionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(
          textAlign: TextAlign.center,
          'Bookmarks',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: newsActionProvider.isLoadingBookmarks
          ? const Center(child: CircularProgressIndicator())
          : newsActionProvider.bookmarkedDocuments.isEmpty
              ? const Center(
                  child: Text(
                    'No bookmarks available',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: newsActionProvider.bookmarkedDocuments.length,
                  itemBuilder: (context, index) {
                    final bookmark =
                        newsActionProvider.bookmarkedDocuments[index];
                    final title = bookmark['title'] ?? '';
                    final newsurl = bookmark['newsurl'] ?? '';
                    final description = bookmark['description'] ?? '';
                    final imageurl = bookmark['imageurl'] ?? '';

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: NewsCard(
                            title: title,
                            newsurl: newsurl,
                            description: description,
                            imageurl: imageurl,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
