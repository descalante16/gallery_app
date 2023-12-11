// gallery_page.dart

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final String apiKey =
      'PKRqhEb7Zwp4jI1C2AcuDzFxPxtazTbqx3rLxbvf3tXUME39Vmg9gPYa'; // Replace with your Pexels API key
  final String apiUrl = 'https://api.pexels.com/v1/curated?per_page=12';

  List<Map<String, dynamic>> images = [];

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  void _fetchImages() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Authorization': apiKey},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> photos = data['photos'];

      setState(() {
        images = List<Map<String, dynamic>>.from(photos.map((dynamic item) {
          return {
            'url': item['src']['medium'],
            'largeUrl': item['src']['large'], // Added larger image URL
            'title': item['photographer'],
          };
        }));
      });
    } else {
      throw Exception('Failed to load images');
    }
  }

  void _openImage(BuildContext context, String largeImageUrl) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 35, 94, 58),
        ),
        body: Center(
          child: Image.network(largeImageUrl),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 35, 94, 58),
        title: Text('DZ Gallery'),
      ),
      body: images.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _openImage(context, images[index]['largeUrl']),
                  child: Container(
                    margin: EdgeInsets.all(5.0),
                    child: GridTile(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(images[index]['url'],
                            fit: BoxFit.cover),
                      ),
                      footer: GridTileBar(
                        backgroundColor: Colors.black54,
                        title: Text(images[index]['title'],
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
