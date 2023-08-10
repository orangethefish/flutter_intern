import 'package:flutter/material.dart';
import 'widgets/cart.dart';

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
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: const Text(
                'Items',
                style: TextStyle(
                  color: Colors.lightGreenAccent,
                ),
              )
            ),
            Container(
              child: Column(
                children: [
                  Text('Cart'),
                  MyCart()
                ],
              )

            )
          ],
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

