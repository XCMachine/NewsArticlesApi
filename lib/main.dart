import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_api/http/http.dart';
import 'package:news_api/providers/home_page_provider.dart';
import 'package:news_api/repositories/repository_articles.dart';
import 'package:provider/provider.dart';
import 'ui/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) =>
          ArticleProvider(ArticlesRepository(ApiService())),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
