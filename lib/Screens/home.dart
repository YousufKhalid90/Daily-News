import 'package:flutter/material.dart';
import 'package:news_project/Screens/bookmark.dart';

import 'package:provider/provider.dart';

import '../Components/curved_nav_bar.dart';
import '../Components/nav_drawer.dart';
import '../Components/news_card.dart';
import '../Components/search_field.dart';
import '../Provider/category_provider.dart';
import '../Provider/headline_provider.dart';

import 'signup.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void initState() {
    super.initState();

    // Fetch headlines when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HeadlineProvider>(context, listen: false).fetchHeadlines();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('Home widget rebuild');

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // This is handled by the search bar itself.
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Text(
          textAlign: TextAlign.center,
          'Nowhere News',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      drawer: const DrawerExample(),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: SizedBox(child: SearchField()),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Headlines',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          Row(
            children: [
              Consumer<HeadlineProvider>(
                  builder: (context, headlineProvider, child) {
                if (headlineProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (headlineProvider.error.isNotEmpty) {
                  return Center(
                      child: Text('Error: ${headlineProvider.error}'));
                } else if (headlineProvider.articles.isEmpty) {
                  return const Center(child: Text('No data'));
                } else {
                  return SizedBox(
                      height: screenHeight * 0.27,
                      width: screenWidth,
                      child: ListView.builder(
                        itemCount: headlineProvider.articles.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final article = headlineProvider.articles[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 10),
                            child: SizedBox(
                              width: screenWidth * 0.8,
                              height: screenHeight * 0.9,
                              child: Card(
                                  elevation: 2, // Adds shadow and elevation
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Rounded corners
                                  ),
                                  child: Container(
                                    width: double
                                        .infinity, // Adjust width as needed
                                    height: 200, // Adjust height as needed
                                    child: Stack(
                                      fit: StackFit
                                          .expand, // Ensures the stack fills the container
                                      children: [
                                        // Background Image
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    article.urlToImage),
                                                fit: BoxFit.fill,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // Rounded corners
                                            ),
                                          ),
                                        ),
                                        // Overlay Text
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            // Semi-transparent black background
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              article.title,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        },
                      ));
                }
              }),
            ],
          ),
          Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
            print('Consumer rebuild');
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: ['Trending', 'Health', 'Sports', 'Finance', 'Tech']
                    .map((category) => Expanded(
                          child: GestureDetector(
                            onTap: () {
                              categoryProvider.selectCategory(category);
                              // Ensure this method is public
                            },
                            child: Container(
                              child: Text(
                                category,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    decoration: categoryProvider
                                                .selectedCategory ==
                                            category
                                        ? TextDecoration
                                            .underline // Underline for selected category
                                        : TextDecoration.none,
                                    color: categoryProvider.selectedCategory ==
                                            category
                                        ? Color.fromARGB(255, 0, 0, 0)
                                        : const Color.fromARGB(
                                            255, 185, 184, 184),
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            );
          }),
          Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
            return Expanded(
              child: ListView(
                children: categoryProvider.articles
                    .map((article) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            height: screenHeight * 0.2,
                            child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: NewsCard(
                                    title: article.title,
                                    newsurl: article.url,
                                    description: article.description,
                                    imageurl: article.urlToImage)),
                          ),
                        ))
                    .toList(),
              ),
            );
          })
        ],
      )),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50), // Circular shape
        ),
        backgroundColor: Color(0xFF005799),
        onPressed: () {},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: SizedBox(
        height: screenHeight * 0.1,
        child: BottomNavBar(
          selectedIndex: 0, // Set the selected index
          onItemTapped: (index) {
            // Handle navigation here
            switch (index) {
              case 0:
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
                // Navigate to home
                break;
              case 1:

                // Navigate to notifications
                break;
              case 2:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Bookmark(),
                  ),
                );
                break;
              case 3:
                // Navigate to profile
                break;
            }
          },
        ),
      ),
    );
  }
}
