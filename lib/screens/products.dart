//import packages
import 'package:flutter/material.dart';

//import widgets
import '../widgets/category_tab.dart';

class Products extends StatefulWidget {
  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Row(
        children: [
          Expanded(child: CategoryTab()) //contains category tab
        ],
      ),
    );
  }
}
