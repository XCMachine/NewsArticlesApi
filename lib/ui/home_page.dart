import 'package:flutter/material.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/providers/home_page_provider.dart';
import 'package:news_api/ui/widgets/article_item_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ArticleProvider? articleProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      articleProvider = Provider.of<ArticleProvider>(context, listen: false);
      await articleProvider?.getArticles();
    });
  }

  @override
  void dispose() {
    super.dispose();
    articleProvider!.dispose();
    articleProvider = null;
  }

  @override
  Widget build(BuildContext context) {
    articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: articleProvider!.isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.lightBlue),
                  SizedBox(height: 30),
                  Text(
                    "Loading",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(Constants.kOverallPadding),
              child: ListView.separated(
                itemCount: articleProvider!.articlesList.articles.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final article = articleProvider?.articlesList.articles[index];

                  return ArticleItem(
                    title: article?.title,
                    description: article?.description,
                    articleSourceName: article?.source.name,
                    url: article?.url,
                    urlToImage: article?.urlToImage,
                    publishedAt: article?.publishedAt,
                    isHovered: articleProvider!.isHovered,
                  );
                },
              ),
            ),
    );
  }
}