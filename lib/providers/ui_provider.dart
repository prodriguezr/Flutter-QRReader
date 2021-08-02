import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  int _selectedOption = 0;

  int get getSelectedOption {
    return this._selectedOption;
  }

  set setSelectedOption(int index) {
    this._selectedOption = index;

    notifyListeners();
  }
}
