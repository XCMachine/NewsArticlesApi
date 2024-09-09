import 'package:flutter/material.dart';
import 'package:news_api/constants.dart';
import 'package:news_api/ui/widgets/source_text_link.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleItem extends StatefulWidget {
  final String? title;
  final DateTime? publishedAt;
  final String? urlToImage;
  final String? description;
  final String? url;
  final bool isHovered;
  final String? articleSourceName;

  const ArticleItem({
    super.key,
    this.title,
    this.publishedAt,
    this.urlToImage,
    this.description,
    this.url,
    this.articleSourceName,
    required this.isHovered,
  });

  @override
  State<ArticleItem> createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title!,
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
            widget.publishedAt.toString().substring(
              0,
              widget.publishedAt.toString().length - 14,
            ),
            style: const TextStyle(color: Colors.lightBlueAccent),
          ),
        ),
        const SizedBox(height: 10),
        Image.network(widget.urlToImage!),
        const SizedBox(height: 30),
        Text(
          widget.description!,
          style: const TextStyle(
            color: Color(Constants.darkishGrey),
            fontSize: Constants.kDescriptionFontSize,
          ),
        ),
        SourceTextLink(
          onTap: () => launchUrl(Uri.parse(widget.url!)),
          text: 'Source: ${widget.url}',
          isHovered: widget.isHovered,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: Constants.kTopPaddingSourceName),
              child: Text(
                "Article written by: ${widget.articleSourceName}",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
