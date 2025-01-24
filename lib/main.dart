import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Articel',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ArticleScreen(),
    );
  }
}

class ArticleScreen extends StatelessWidget {
  ArticleScreen({super.key});

  final Map<String, dynamic> dataArticle = {
    "data": [
      {
        "type": "articles",
        "id": "1",
        "attributes": {"title": "JSON:API paints my bikeshed!"},
        "relationships": {
          "author": {
            "links": {
              "self": "http://example.com/articles/1/relationships/author",
              "related": "http://example.com/articles/1/author"
            },
            "data": {"type": "people", "id": "9"}
          },
          "comments": {
            "links": {
              "self": "http://example.com/articles/1/relationships/comments",
              "related": "http://example.com/articles/1/comments"
            },
            "data": [
              {"type": "comments", "id": "5"},
              {"type": "comments", "id": "12"}
            ]
          }
        },
        "links": {"self": "http://example.com/articles/1"}
      },
    ]
  };

  @override
  Widget build(BuildContext context) {
    final articles = dataArticle['data'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Article Viewer UAS"),
      ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          final title = article['attributes']['title'];
          final authorId = article['relationships']['author']['data']['id'];
          final comments = article['relationships']['comments']['data'];
          final link = article['links']['self'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Section
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.person, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Text(
                          "Author ID: $authorId",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.comment, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Comments:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ...comments
                                  .map<Widget>((comment) => Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Text(
                                          "- Comment ID: ${comment['id']}",
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Link Section
                    Row(
                      children: [
                        const Icon(Icons.link, color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            link,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
