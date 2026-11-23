import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class AppointmentHeader extends StatelessWidget {
  final VoidCallback onBack;
  final String title;

  const AppointmentHeader({
    super.key,
    required this.onBack,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onBack,
              child: Icon(Icons.arrow_back_ios_new, size: 21),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.button,
            ),
          ),
        ],
      ),
    );
  }
}