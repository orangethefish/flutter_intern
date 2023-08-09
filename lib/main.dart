import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CakeStory'),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Center(
          child: const Text(
              'Hello, World!',
              style: TextStyle(
                backgroundColor: Colors.black,
                color: Colors.white
              ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your action here
          },
          backgroundColor: Colors.amber[200],
          child: Icon(Icons.shopping_cart),

        ),
      ),
    );
  }
}
