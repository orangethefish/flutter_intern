import 'package:flutter/material.dart';


class CartNotifier extends ChangeNotifier {
  // Define any relevant variables and methods

  void triggerRerender() {
    notifyListeners(); // Notify listeners to trigger a rebuild
  }
}
