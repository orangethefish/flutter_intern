import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dart:async';


class DelayedIncrementDecrementButtons extends StatefulWidget {
  final CartItem cartItem;
  final ValueChanged<int> onQuantityChanged;
  const DelayedIncrementDecrementButtons({super.key,required this.cartItem, required this.onQuantityChanged});

  @override
  _DelayedIncrementDecrementButtonsState createState() =>
      _DelayedIncrementDecrementButtonsState();
}

class _DelayedIncrementDecrementButtonsState
    extends State<DelayedIncrementDecrementButtons> {
  late Timer _timer;
  int _incrementDecrementValue = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 1), _handleIncrementDecrement);
  }

  void _handleIncrementDecrement() {
    // Implement your increment and decrement logic here
    widget.onQuantityChanged(
      _incrementDecrementValue,
    );
  }

  void _handleIncrement() {
    setState(() {
      _incrementDecrementValue++;
    });
    _timer.cancel();
    _timer = Timer(Duration(seconds: 1), _handleIncrementDecrement);
  }

  void _handleDecrement() {
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
        IconButton(
          onPressed: _handleDecrement,
          icon: Icon(Icons.remove),
        ),
        Text('${widget.cartItem.quantity + _incrementDecrementValue}'),
        IconButton(
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
