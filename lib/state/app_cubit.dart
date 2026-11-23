import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/app_repository.dart';
import 'app_state.dart';
import 'load_status.dart';

class AppCubit extends Cubit<AppState> {
  final AppRepository repository;

  AppCubit(this.repository) : super(const AppState());

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading, error: null));
    try {
      final data = await repository.loadAppData();
      emit(
        state.copyWith(
          status: data.doctors.isEmpty ? LoadStatus.empty : LoadStatus.success,
          data: data,
          selectedHour: (data.details['workingHours']['slots'] as List)
              .indexWhere((e) => e['selected'] == true)
              .clamp(0, 9999),
          selectedDate: (data.details['date']['slots'] as List)
              .indexWhere((e) => e['selected'] == true)
              .clamp(0, 9999),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: LoadStatus.error,
          error: 'Unable to load application data. Please try again.',
        ),
      );
    }
  }

  void selectHour(int index) => emit(state.copyWith(selectedHour: index));

  void selectDate(int index) => emit(state.copyWith(selectedDate: index));

  void search(String value) => emit(state.copyWith(query: value));

  void setFilter(String value) => emit(state.copyWith(filter: value));

  void setSort(String value) => emit(state.copyWith(sort: value));

  void toggleFavorite(String id) {
    final data = state.data;
    if (data == null) return;
    final updated = data.doctors
        .map((d) => d.id == id ? d.copyWith(isFavorite: !d.isFavorite) : d)
        .toList();
    emit(state.copyWith(data: data.copyWithDoctors(updated)));
  }
}