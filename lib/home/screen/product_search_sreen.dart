

import 'package:dream_ai/home/components/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class ProductSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _typeAheadController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: TypeAheadField(
          controller: _typeAheadController,
          suggestionsCallback: (pattern) async {
            return await fetchProductSuggestions(pattern);
          },
          builder: (context, controller, focusNode) {
            return TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(color: AppColors.lightBlue),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Enter product name',
                  // helperText: 'Search for products...',
                  helperMaxLines: 2),
            );
          },
          emptyBuilder: (context) {
            return InkWell(
              onTap:(){
                Navigator.pop(context, _typeAheadController.text);
              } ,
              child: ListTile(
                title: Text(_typeAheadController.text),
              ),
            );
          },
          itemBuilder: (context, suggestion) {
            // Customize how each suggestion is displayed
            return ListTile(
              leading: Icon(
                Icons.search,
                size: 15,
              ),
              title: Text(suggestion['name']),
            );
          },
          onSelected: (suggestion) {
            // Handle when a product suggestion is selected
            // Example: Navigate to product details page
            Navigator.pop(context, suggestion['name']);
          },
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchProductSuggestions(
      String pattern) async {
    // Example of fetching product suggestions from an API
    // Replace with your actual API call
    // Simulating API call with dummy data
    await Future.delayed(Duration(milliseconds: 300));
    List<Map<String, dynamic>> allProducts = [
      {
        'name': 'Apple iPhone 15 Pro (128 GB) - Natural Titanium',
        'image': 'https://example.com/iphone13pro.jpg',
        'price': 1099.99,
      },
      {
        'name': 'Apple iPhone 15 Pro Max (256 GB) - Natural Titanium',
        'image': 'https://example.com/iphone13promax.jpg',
        'price': 1199.99,
      },
      {
        'name': 'Apple iPhone 15 Plus (128 GB) - Natural Titanium',
        'image': 'https://example.com/iphone15pro.jpg',
        'price': 1299.99,
      },
      {
        'name': 'Apple iPhone 14 Pro (128 GB) - Natural Titanium',
        'image': 'https://example.com/iphone15plus.jpg',
        'price': 1399.99,
      },
    ];

    // Filter products based on the pattern
    return allProducts.where((product) {
      return product['name'].toLowerCase().contains(pattern.toLowerCase());
    }).toList();
  }
}
