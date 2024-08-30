import 'package:flutter/material.dart';

class SourceTextLink extends StatefulWidget {
  final void Function()? onTap;
  final String? text;
  bool? isHovered;

  SourceTextLink({
    super.key,
    this.onTap,
    this.text,
    this.isHovered,
  });

  @override
  State<SourceTextLink> createState() => _SourceTextLinkState();
}

class _SourceTextLinkState extends State<SourceTextLink> {
@override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() => widget.isHovered = true);
      },
      onExit: (event) {
        setState(() => widget.isHovered = false);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text!,
          style: TextStyle(
            color: widget.isHovered! ? Colors.lightBlueAccent : Colors.grey,
            fontSize: 17,
            decoration: widget.isHovered! ? TextDecoration.underline : TextDecoration.none,
            decorationColor: widget.isHovered! ? Colors.lightBlueAccent : Colors.grey,
          ),
          selectionColor: Colors.lightBlue,
        ),
      ),
    );
  }
}

// launchUrl(Uri.parse(article.url)); -> onTap
// 'Source: ${article.url}', -> String on Text
