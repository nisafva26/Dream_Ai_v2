import 'dart:developer';

import 'package:dream_ai/api_service.dart/chatgpt.dart';
import 'package:dream_ai/model/product_price.dart';
import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  List<ProductPrice> _prices = [];
  bool _loading = false;

  bool _isPriceloading = false;
  bool get isPriceloading => _isPriceloading;

  List<ProductPrice> get prices => _prices;
  bool get loading => _loading;

  String _description = '';
  String get description => _description;
  

  Future<void> fetchPrices(String productName) async {
    log('inside api call');
    _isPriceloading = true;
    notifyListeners();
    _prices = await ApiService().fetchPrices(productName);
    log('prices in provider : ${_prices}');
    _isPriceloading = false;
    notifyListeners();
  }

  Future<void> fetchDescription(String productName) async {
    log('inside api call');
    _loading = true;
    notifyListeners();
    _description = await ApiService().generateDescription(productName);
    log('description in provider : ${_description}');
    _loading = false;
    notifyListeners();
  }
}
