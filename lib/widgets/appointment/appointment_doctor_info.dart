import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/widgets/data_image.dart';

class AppointmentDoctorInfo extends StatelessWidget {
  final Map<String, dynamic> doctor;
  final Map<String, dynamic> payment;

  const AppointmentDoctorInfo({
    super.key,
    required this.doctor,
    required this.payment,
  });

  @override
  Widget build(BuildContext context) {
    final actions = doctor['actions'] as Map<String, dynamic>;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: DataImage(
            source: doctor['avatarUrl'] as String,
            width: 132,
            height: 132,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SizedBox(
            height: 112,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          doctor['name'] as String,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    if (actions['message'] == true) ...[
                      _actionIcon(Icons.chat_bubble_outline),
                      const SizedBox(width: 8),
                    ],
                    if (actions['call'] == true) ...[
                      _actionIcon(Icons.phone_outlined),
                      const SizedBox(width: 8),
                    ],
                    if (actions['videoCall'] == true)
                      _actionIcon(Icons.videocam_outlined),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  doctor['clinic'] as String,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.lightTeal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        payment['label'] as String,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      payment['formatted'] as String,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.lightTeal,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _actionIcon(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        color: Color(0xFFE1F3F2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 17, color: AppColors.dark),
    );
  }
}