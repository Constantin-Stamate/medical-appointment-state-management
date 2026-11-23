import 'package:flutter/material.dart';

import '../../core/widgets/data_image.dart';
import '../../core/constants/app_colors.dart';

class DoctorTile extends StatelessWidget {
  final String image;
  final String name;
  final String role;
  final String address;
  final bool isFavorite;
  final VoidCallback? onFavorite;

  const DoctorTile({
    super.key,
    required this.image,
    required this.name,
    required this.role,
    required this.address,
    this.isFavorite = false,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(child: DataImage(source: image, width: 46, height: 46)),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.dark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                role,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 18),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      address,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.dark,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: onFavorite,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 20,
            color: isFavorite ? Colors.red : AppColors.grey,
          ),
        ),
      ],
    );
  }
}