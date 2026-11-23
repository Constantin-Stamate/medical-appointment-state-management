import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class HomeSearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onOptionSelected;

  const HomeSearchBar({
    super.key,
    required this.hint,
    required this.onChanged,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) => Container(
    height: 52,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: AppColors.soft,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        const Icon(Icons.search, size: 24, color: AppColors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            onChanged: onChanged,
            style: const TextStyle(fontSize: 14, color: AppColors.dark),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontSize: 14,
                color: AppColors.grey,
                fontWeight: FontWeight.w400,
              ),
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ),
        PopupMenuButton<String>(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.tune, size: 24, color: AppColors.grey),
          onSelected: onOptionSelected,
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'sort:name', child: Text('Sort by name')),
            PopupMenuItem(
              value: 'sort:specialty',
              child: Text('Sort by specialty'),
            ),
            PopupMenuItem(value: 'filter:all', child: Text('All doctors')),
            PopupMenuItem(value: 'filter:favorites', child: Text('Favorites')),
          ],
        ),
      ],
    ),
  );
}