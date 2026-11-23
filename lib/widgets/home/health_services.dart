import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/data_image.dart';
import '../common/section_title.dart';

class HealthServices extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final String title;

  const HealthServices({
    super.key,
    required this.services,
    required this.title,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: [
      SectionTitle(title, showSeeAll: true, seeAllLabel: 'See All'),
      const SizedBox(height: 18),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (final item in services)
            Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.soft,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DataImage(
                    source: item['iconUrl'] as String,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['name'] as String,
                  style: const TextStyle(fontSize: 14, color: AppColors.grey),
                ),
              ],
            ),
        ],
      ),
    ],
  );
}