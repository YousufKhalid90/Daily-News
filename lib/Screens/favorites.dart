import 'package:flutter/material.dart';
import 'package:news_project/Provider/newsaction_provider.dart';
import 'package:provider/provider.dart';
import '../Components/news_card.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _favoriteState();
}

class _favoriteState extends State<Favorites> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('retrieving favorite');
      Provider.of<NewsActionProvider>(context, listen: false).getFavorite();
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
          'Favorites',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: newsActionProvider.isLoadingBookmarks
          ? const Center(child: CircularProgressIndicator())
          : newsActionProvider.favoriteDocuments.isEmpty
              ? const Center(
                  child: Text(
                    'No Favorites',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: newsActionProvider.favoriteDocuments.length,
                  itemBuilder: (context, index) {
                    final favor = newsActionProvider.favoriteDocuments[index];
                    final title = favor['title'] ?? '';
                    final newsurl = favor['newsurl'] ?? '';
                    final description = favor['description'] ?? '';
                    final imageurl = favor['imageurl'] ?? '';

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
