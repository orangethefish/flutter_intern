import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/cart.dart';
import 'screens/products.dart';

import 'services/cart_notifier.dart';



void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CakeStory'),
          backgroundColor: Colors.teal,
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
                  Expanded(child: Consumer<CartNotifier>(
                    builder: (context, cartNotifier, child) {
                      return MyCart();
                    },
                  ),)
                ],
              )

            )
          ],
        ),
      ),
    );
  }
}

