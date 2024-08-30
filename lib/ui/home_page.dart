import 'package:flutter/material.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/providers/home_page_provider.dart';
import 'package:news_api/ui/widgets/source_text_link.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final articleProvider =
          Provider.of<ArticleProvider>(context, listen: false);
      await articleProvider.getArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = Provider.of<ArticleProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: articleProvider.isLoading
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
          : Expanded(
            child: Padding(
                padding: const EdgeInsets.all(Constants.kOverallPadding),
                child: ListView.separated(
                  itemCount: articleProvider.articlesList.articles.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final article = articleProvider.articlesList.articles[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          article.title,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: Constants.kTitleFontSize,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: Constants.kLeftPaddingPublishedAt,
                            top: Constants.kTopPaddingPublishedAt,
                          ),
                          child: Text(
                            article.publishedAt.toString().substring(
                                  0,
                                  article.publishedAt.toString().length - 14,
                                ),
                            style: const TextStyle(color: Colors.lightBlueAccent),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Image.network(article.urlToImage),
                        const SizedBox(height: 30),
                        Text(
                          article.description,
                          style: const TextStyle(
                            color: Color(Constants.darkishGrey),
                            fontSize: Constants.kDescriptionFontSize,
                          ),
                        ),
                        SourceTextLink(
                          onTap: () => launchUrl(Uri.parse(article.url)),
                          text: 'Source: ${article.url}',
                          isHovered: articleProvider.isHovered,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Constants.kTopPaddingSourceName),
                              child: Text(
                                "Article written by: ${article.source.name}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    );
                  },
                ),
              ),
          ),
    );
  }
}
