//import packages
import 'package:flutter/material.dart';
import 'dart:async';

//import apis
import '../services/api_service.dart';


class ProductsList extends StatefulWidget {
  final Item item;
  const ProductsList({super.key,required this.item});//CategoryTab pass an item to ProductsList to render
  @override
  State<ProductsList> createState() => _ProductsListState(item:item);
}

class _ProductsListState extends State<ProductsList> {
  final Item item;

  bool isCardDoubleTapped=false;
  void _handleCardDoubleTap(Item item)async{ //handle double tap on each card
    setState(() { //trigger rerender
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
    return GestureDetector(
        onDoubleTap:(){ //double tap detection
          _handleCardDoubleTap(item);
        },

        child: Card(
          elevation: isCardDoubleTapped? 8 : 2, //styling when double tapped
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
              Image.network(item.image), //render image
              SizedBox(height: 8),
              Text('${item.prodName} - ${item.prodPrice}£', //render name and price
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
