import 'package:flutter/material.dart';
import 'package:news_project/Screens/bookmark.dart';
import 'package:news_project/Screens/favorites.dart';
import 'package:news_project/Screens/home.dart';

import '../Screens/settings.dart';

/// Flutter code sample for [Drawer] with navigation.

class DrawerExample extends StatelessWidget {
  const DrawerExample({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      backgroundColor: Color(0xFF005799),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.20,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF005799),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                CircleAvatar(
                  radius: screenHeight * 0.04,
                  backgroundColor: const Color.fromARGB(255, 204, 196, 194),
                  child: const Text('AH'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Username',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white, // Override the color
                        ),
                  ),
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(
                  color: Color.fromARGB(255, 255, 255, 255),
                  Icons.message_outlined),
              title: Text(
                'News',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Color.fromARGB(
                          255, 255, 255, 255), // Override the color
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Home(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(
                  color: Color.fromARGB(255, 255, 255, 255),
                  Icons.favorite_border_outlined),
              title: Text(
                'favorite',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Color.fromARGB(
                          255, 255, 255, 255), // Override the color
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Favorites(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(
                  color: Color.fromARGB(255, 255, 255, 255),
                  Icons.bookmark_add_outlined),
              title: Text(
                'Bookmark',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Color.fromARGB(
                          255, 255, 255, 255), // Override the color
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Bookmark(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(
                  color: Color.fromARGB(255, 255, 255, 255),
                  Icons.settings_outlined),
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Color.fromARGB(
                          255, 255, 255, 255), // Override the color
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(
                  color: Color.fromARGB(255, 255, 255, 255),
                  Icons.logout_outlined),
              title: Text(
                'Logout',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Color.fromARGB(
                          255, 255, 255, 255), // Override the color
                    ),
              ),
              onTap: () {
                Navigator.of(context).pop(); // Close the drawer
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
