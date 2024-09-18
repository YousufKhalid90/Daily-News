import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_project/Network/api_client.dart';
import 'package:news_project/Network/news_service.dart';
import 'package:news_project/Provider/headline_provider.dart';
import 'package:news_project/Provider/login_form_provider.dart';
import 'package:news_project/Provider/newsaction_provider.dart';
import 'package:news_project/Provider/search_provider.dart';
import 'package:news_project/Provider/signup_provider.dart';
import 'package:news_project/Screens/login.dart';
import 'package:news_project/Utils/theme.dart';

import 'package:provider/provider.dart';

import 'Provider/category_provider.dart';

void main() async {
  final newsService =
      NewsService(apiClient: ApiClient(baseUrl: 'https://newsapi.org/v2'));
  final headlineProvider = HeadlineProvider(newsService: newsService);
  final categoryProvider = CategoryProvider(newsService: newsService);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginFormProvider()),
    ChangeNotifierProvider(create: (_) => SignupProvider()),
    ChangeNotifierProvider(create: (_) => SearchProvider()),
    ChangeNotifierProvider(create: (_) => NewsActionProvider()),
    ChangeNotifierProvider(create: (_) => headlineProvider),
    ChangeNotifierProvider(create: (_) => categoryProvider),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: appTheme,
      home: const LoginPage(title: 'Flutter Demo Home Page'),
    );
  }
}
