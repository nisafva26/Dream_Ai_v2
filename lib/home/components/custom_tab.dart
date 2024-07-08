import 'dart:developer';

import 'package:dream_ai/home/components/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTab extends StatelessWidget {
  final String label;
  final TabController tabController;
  final int index;

  CustomTab(
      {required this.label, required this.tabController, required this.index});

  @override
  Widget build(BuildContext context) {
    log('tab index ; ${tabController.index}');
    bool isSelected = tabController.index == index;

    return Tab(
      iconMargin: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightBlue : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
          // border: Border.all(
          //   color: isSelected ? Colors.blue : Colors.grey,
          //   width: 1,
          // ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}
