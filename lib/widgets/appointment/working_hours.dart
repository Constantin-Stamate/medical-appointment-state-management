import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class WorkingHours extends StatelessWidget {
  final List<String> hours;
  final String title;
  final String seeAllLabel;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const WorkingHours({
    super.key,
    required this.hours,
    required this.title,
    required this.seeAllLabel,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.dark,
              ),
            ),
            Text(
              seeAllLabel,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 48,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: hours.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, index) {
              final isSelected = index == selectedIndex;

              return GestureDetector(
                onTap: () => onSelected(index),
                child: Container(
                  width: 112,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.button : AppColors.soft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    hours[index],
                    style: TextStyle(
                      fontSize: 15,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}