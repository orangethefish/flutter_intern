//import packages
import 'package:flutter/material.dart';

//import widgets
import 'screens/cart.dart';
import 'screens/products.dart';

void main() {
  runApp(
     MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // splits MyApp in two halves (Products and MyCart)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar( //title
          title: const Text('CakeStory'),
          backgroundColor: Colors.teal,
        ),
        body: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1, //two equal halves
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
                  Expanded(child:MyCart())
                ],
              )

            )
          ],
        ),
      ),
    );
  }
}

