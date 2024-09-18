import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Provider/newsaction_provider.dart';

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageurl;
  final String newsurl;

  // ignore: use_super_parameters
  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageurl,
    required this.newsurl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsActionProvider>(context);
    final bool isFavorite = newsProvider.isFavorite(title, description);
    final bool isBookmark = newsProvider.isbookmark(title, description);

    final double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(newsurl);
        try {
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            throw 'Could not launch $newsurl';
          }
        } catch (e) {
          print(e);
        }
      },
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  width: screenHeight * 0.14,
                  height: screenHeight * 0.14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.blueAccent,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageurl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text(
                            'Image',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 9, 8, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: 12,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      SizedBox(
                        height: screenHeight * 0.04,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Toggle the favorite status
                                newsProvider.toggleFavorite(
                                    title, imageurl, newsurl, description);
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                size: screenHeight * 0.03,
                                color: isFavorite ? Colors.red : Colors.grey,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                // Toggle the favorite status
                                newsProvider.toggleBookmark(
                                    title, imageurl, newsurl, description);
                              },
                              icon: Icon(
                                isBookmark
                                    ? Icons.bookmark
                                    : Icons.bookmark_add_outlined,
                                size: screenHeight * 0.03,
                                color: isBookmark
                                    ? Color(0xFF005799)
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
