//import packages
import 'package:flutter/material.dart';

//import apis
import '../services/api_service.dart';

//import widgets
import '../widgets/cart_items.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});
  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  void _handleCartChange() { //rerender every time cart changes
    setState(() {
      _cartItemsFuture = getCart();
    });
  }
  Future<List<CartItem>> _cartItemsFuture = Future(() => []);
  String calculateTotal(List<CartItem> cartItems) { //calculate total
    double total = 0;
    for (var cartItem in cartItems) {
      total += cartItem.subtotal;
    }
    return total.toStringAsFixed(2);
  }
  @override
  void initState(){
    _cartItemsFuture = getCart(); //fetch api
  }
  Widget build(BuildContext context) {
    return FutureBuilder<List<CartItem>>(
      future: _cartItemsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No items in the cart.');
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder( //render items
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    CartItem cartItem = snapshot.data![index];
                    return ListTile(
                      leading: Image.network(cartItem.image), //image
                      title: Text(cartItem.prodName), //name
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              DelayedIncrementDecrementButtons( //add or reduce in quantity
                                cartItem: cartItem,
                                onQuantityChanged: (difference){ //if quantity changes(when user press + or - button), trigger rerender
                                  if(difference!=0) {
                                    addItemToCart(cartItem, difference).then((
                                        _) {
                                      _handleCartChange();
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                          Text('${cartItem.prodPrice.toStringAsFixed(2)}£'), //price per item
                          Text('${cartItem.subtotal.toStringAsFixed(2)}£'), //subtotal
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10), //line
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30), //total to pay
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent
                      ),
                    ),
                    Text(
                      '${calculateTotal(snapshot.data!)}£',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

        }
      },
    );
    return const Placeholder();
  }
}