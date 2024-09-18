// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Network/api_client.dart';
import '../Network/auth_service.dart';
import '../Network/news_service.dart';
import '../Provider/login_form_provider.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPage> {
  late NewsService newsService;

  @override
  void initState() {
    super.initState();
    // Initialize NewsService with ApiClient
    newsService =
        NewsService(apiClient: ApiClient(baseUrl: 'https://newsapi.org/v2'));

    // Fetch and print news
    _fetchAndPrintNews();
  }

  Future<void> _fetchAndPrintNews() async {
    try {
      final newsResponse = await newsService.fetchNews();
      // Print each article's title
      for (var article in newsResponse.articles) {
        print('Title: ${article.title}');
      }
    } catch (e) {
      print('Error fetching news: $e');
    }
  }

  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final formProvider = Provider.of<LoginFormProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              // ignore: duplicate_ignore
              // ignore: prefer_const_constructors
              Text(
                'Nowhere News',
                style: Theme.of(context).textTheme.titleLarge,
              ),

              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(30, 30, 0, 20),
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 6),
                    child: Text('Email',
                        style: Theme.of(context).textTheme.bodyMedium),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: TextField(
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                  onChanged: (value) => formProvider.setEmail(value),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.all(8),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFF005799), // Border color when focused
                          width: 1.0,
                        )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ), // Adds a border
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 0, 6),
                    child: Text('Password',
                        style: Theme.of(context).textTheme.bodyMedium),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                child: TextField(
                  onChanged: (value) => formProvider.setPassword(value),
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',

                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ), // Adds a border
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                    child: Text('Forgot your password ?',
                        style: Theme.of(context).textTheme.bodySmall),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 60, 50, 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF005799),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const Home(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.white, // Override the color
                            ),
                      )),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Color(0xFF005799), // Custom color
                      thickness: 1, // Custom thickness
                      indent: 70, // Indent from the left
                      endIndent: 10, // Indent from the right
                      height: 40,
                    ),
                  ),
                  Text(
                    'Or',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Color(0xFF005799),
                          fontWeight: FontWeight.w400, // Override the color
                        ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color(0xFF005799), // Custom color
                      thickness: 1, // Custom thickness
                      indent: 10, // Indent from the left
                      endIndent: 70, // Indent from the right
                      height: 40,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        side: BorderSide(
                          color: Color(0xFF005799), // Blue border color
                          width: 1.0, // Border thickness
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // Rounded corners
                        ),
                      ),
                      onPressed: () async {
                        User? user = await _authService.signInWithGoogle();

                        // Handle what happens after successful login
                        if (user != null) {
                          // Navigate to the next screen or show success message
                          print('Signed in as ${user.displayName}');
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                          ); // Example navigation
                        } else {
                          print('Sign in failed');
                        }
                      },
                      child: Text(
                        'G+ Sign in with Google',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Color(0xFF005799), // Override the color
                            ),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Create an account?',
                      style: Theme.of(context).textTheme.bodySmall),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text('Sign Up',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Color(0xFF005799))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
