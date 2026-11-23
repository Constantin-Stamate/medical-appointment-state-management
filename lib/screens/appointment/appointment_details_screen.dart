import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../state/app_cubit.dart';
import '../../state/app_state.dart';
import '../../widgets/appointment/appointment_dates.dart';
import '../../widgets/appointment/appointment_doctor_info.dart';
import '../../widgets/appointment/appointment_header.dart';
import '../../widgets/appointment/book_appointment_button.dart';
import '../../widgets/appointment/working_hours.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  const AppointmentDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          if (state.data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final details = state.data!.details;
          final hourInfo = details['workingHours'] as Map<String, dynamic>;
          final dateInfo = details['date'] as Map<String, dynamic>;

          final selectedHour = state.selectedHour;
          final selectedDate = state.selectedDate;

          final hours = (details['workingHours']['slots'] as List)
              .map((e) => e['label'] as String)
              .toList();

          final dates = (details['date']['slots'] as List)
              .map((e) => e['label'] as String)
              .toList();

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppointmentHeader(
                        title: details['title'] as String,
                        onBack: () => Navigator.pop(context),
                      ),
                      const SizedBox(height: 20),

                      AppointmentDoctorInfo(
                        doctor: Map<String, dynamic>.from(
                          details['doctor'] as Map,
                        ),
                        payment: Map<String, dynamic>.from(
                          details['payment'] as Map,
                        ),
                      ),
                      const SizedBox(height: 28),

                      Text(
                        details['details']['title'] as String,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        details['details']['description'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.grey,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28),

                      WorkingHours(
                        hours: hours,
                        title: hourInfo['title'] as String,
                        seeAllLabel: hourInfo['showAll'] == true
                            ? 'See All'
                            : '',
                        selectedIndex: selectedHour,
                        onSelected: context.read<AppCubit>().selectHour,
                      ),
                      const SizedBox(height: 24),

                      AppointmentDates(
                        dates: dates,
                        title: dateInfo['title'] as String,
                        seeAllLabel: dateInfo['showAll'] == true
                            ? 'See All'
                            : '',
                        selectedIndex: selectedDate,
                        onSelected: context.read<AppCubit>().selectDate,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              BookAppointmentButton(
                label: details['actions']['bookAppointment']['label'] as String,
                onPressed:
                    details['actions']['bookAppointment']['enabled'] == true &&
                        hours.isNotEmpty &&
                        dates.isNotEmpty
                    ? () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${dates[selectedDate]} • ${hours[selectedHour]}',
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          );
        },
      ),
    ),
  );
}