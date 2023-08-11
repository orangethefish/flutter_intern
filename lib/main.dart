import 'package:flutter/material.dart';
import 'screens/cart.dart';
import 'screens/products.dart';
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
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(child: Products())
                ],
              )
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(child: MyCart())
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

