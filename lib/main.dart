// main.dart

import 'package:flutter/material.dart';
import 'gallery_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desirie | API Activity',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: false,
      ).copyWith(scaffoldBackgroundColor: Color.fromARGB(255, 156, 51, 51)),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 35, 94, 58),
        title: Text(
          'DZ Gallery',
        ),
        leading: Icon(Icons.code),
      ),
      body: Center(
        child: Container(
          width: 150.0,
          height: 50.0,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GalleryPage()),
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(222, 41, 128, 54)),
            child: Text(
              'Open Gallery',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
