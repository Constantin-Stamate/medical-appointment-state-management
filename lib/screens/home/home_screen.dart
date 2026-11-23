import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../../widgets/home/search_bar.dart';
import '../../widgets/common/section_title.dart';
import '../../state/app_cubit.dart';
import '../../state/app_state.dart';
import '../../state/load_status.dart';
import '../../widgets/appointment/appointment_card.dart';
import '../../widgets/doctor/doctor_tile.dart';
import '../../widgets/home/health_services.dart';
import '../../widgets/home/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            if (state.status == LoadStatus.loading ||
                state.status == LoadStatus.initial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == LoadStatus.error) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 42,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(state.error ?? ('Unable to load application data')),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => context.read<AppCubit>().load(),
                      child: Text('Try again'),
                    ),
                  ],
                ),
              );
            }

            final cubit = context.read<AppCubit>();
            final doctors = state.visibleDoctors;
            final home = state.data!.home;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HomeHeader(
                    user: Map<String, dynamic>.from(home['user'] as Map),
                    notifications: Map<String, dynamic>.from(
                      home['notifications'] as Map,
                    ),
                  ),
                  const SizedBox(height: 24),

                  HomeSearchBar(
                    hint: (home['search'] as Map)['hint'] as String? ?? '',
                    onChanged: cubit.search,
                    onOptionSelected: (value) {
                      if (value.startsWith('sort:')) {
                        cubit.setSort(value.substring(5));
                      } else if (value.startsWith('filter:')) {
                        cubit.setFilter(value.substring(7));
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  AppointmentCard(
                    appointment: Map<String, dynamic>.from(
                      home['appointment'] as Map,
                    ),
                  ),
                  const SizedBox(height: 24),
                  HealthServices(
                    services: state.data!.services,
                    title: 'Health Services',
                  ),
                  const SizedBox(height: 24),

                  const SectionTitle(
                    'Nearby Doctor',
                    showSeeAll: true,
                    seeAllLabel: 'See All',
                  ),
                  const SizedBox(height: 18),

                  if (doctors.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      child: Center(
                        child: Text(
                          'No doctors found',
                          style: TextStyle(color: AppColors.grey),
                        ),
                      ),
                    )
                  else
                    ...doctors.map(
                      (doctor) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: DoctorTile(
                          image: doctor.avatarUrl,
                          name: doctor.name,
                          role: doctor.specialty,
                          address: doctor.distance,
                          isFavorite: doctor.isFavorite,
                          onFavorite: () => cubit.toggleFavorite(doctor.id),
                        ),
                      ),
                    ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}