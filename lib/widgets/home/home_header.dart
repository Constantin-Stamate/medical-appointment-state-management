import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/data_image.dart';

class HomeHeader extends StatelessWidget {
  final Map<String, dynamic> user;
  final Map<String, dynamic> notifications;

  const HomeHeader({
    super.key,
    required this.user,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          ClipOval(
            child: DataImage(
              source: user['avatarUrl'] as String,
              width: 44,
              height: 44,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user['greeting'] as String,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                user['subtitle'] as String,
                style: const TextStyle(fontSize: 10, color: AppColors.grey),
              ),
            ],
          ),
        ],
      ),
      Stack(
        children: [
          SizedBox(
            width: 44,
            height: 44,
            child: Center(
              child: Icon(
                Icons.notifications_none,
                size: 23,
                color: AppColors.dark,
              ),
            ),
          ),
          if (notifications['hasUnread'] == true)
            Positioned(
              right: 10,
              top: 9,
              child: CircleAvatar(radius: 4, backgroundColor: Colors.red),
            ),
        ],
      ),
    ],
  );
}