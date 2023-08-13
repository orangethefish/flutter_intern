import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../services/api_service.dart';
import '../services/cart_notifier.dart';

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
    await addItemToCart(item, 1);
    Future.delayed(const Duration(seconds: 2),(){
      setState(() {
        isCardDoubleTapped=false;
      });
    });

  }
  _ProductsListState({required this.item});
  @override
  Widget build(BuildContext context) {
    final cartNotifier = context.watch<CartNotifier>();
    return GestureDetector(
        onDoubleTap:(){
          _handleCardDoubleTap(item);
          cartNotifier.triggerRerender();
        },

        child: Card(
          elevation: isCardDoubleTapped? 8 : 2,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: isCardDoubleTapped? Colors.black : Colors.transparent,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(8.0)
          ),
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
