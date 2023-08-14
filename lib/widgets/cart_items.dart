//import packages
import 'package:flutter/material.dart';
import 'dart:async';

//import apis
import '../services/api_service.dart';





class DelayedIncrementDecrementButtons extends StatefulWidget {
  final CartItem cartItem;
  final ValueChanged<int> onQuantityChanged; // function handles quantity changes
  const DelayedIncrementDecrementButtons({super.key,required this.cartItem, required this.onQuantityChanged});  //the cart doesn't call api instant but 1 second after user's series of clicks

  @override
  _DelayedIncrementDecrementButtonsState createState() =>
      _DelayedIncrementDecrementButtonsState();
}

class _DelayedIncrementDecrementButtonsState
    extends State<DelayedIncrementDecrementButtons> {
  late Timer _timer; //time to wait after last input
  int _incrementDecrementValue = 0; //difference between before and after inputs

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 1), _handleIncrementDecrement); //1 second
  }

  void _handleIncrementDecrement() {
    // Implement your increment and decrement logic here
    widget.onQuantityChanged(
      _incrementDecrementValue, //pass the difference
    );
  }

  void _handleIncrement() {
    setState(() { //handle + inputs
      _incrementDecrementValue++;
    });
    _timer.cancel();
    _timer = Timer(Duration(seconds: 1), _handleIncrementDecrement);
  }

  void _handleDecrement() { //handle - inputs
    if (_incrementDecrementValue >= 0) {
      setState(() {
        _incrementDecrementValue--;
      });
    }
    _timer.cancel();
    _timer = Timer(Duration(seconds: 1), _handleIncrementDecrement);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton( // - button
          onPressed: _handleDecrement,
          icon: Icon(Icons.remove),
        ),
        Text('${widget.cartItem.quantity + _incrementDecrementValue}'),
        IconButton( // + button
          onPressed: _handleIncrement,
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
