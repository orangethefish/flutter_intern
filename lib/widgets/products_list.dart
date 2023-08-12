import 'package:flutter/material.dart';

import '../services/api_service.dart';

class ProductsList extends StatefulWidget {
  final Item item;
  const ProductsList({super.key,required this.item});
  @override
  State<ProductsList> createState() => _ProductsListState(item:item);
}

class _ProductsListState extends State<ProductsList> {
  final Item item;
  bool isCardDoubleTapped=false;
  void _handleCardDoubleTap(Item item)async{
    setState(() {
      isCardDoubleTapped = true;
    });
    await addItemToCart(item);
    isCardDoubleTapped=false;
  }
  _ProductsListState({required this.item});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onDoubleTap:(){

        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(item.image),
              SizedBox(height: 8),
              Text('${item.prodName} - ${item.prodPrice}£',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
    );
  }
}
