import '../models/app_data.dart';
import '../models/doctor.dart';

import 'load_status.dart';

class AppState {
  final LoadStatus status;
  final AppData? data;
  final String query;
  final String filter;
  final String sort;
  final String? error;
  final int selectedHour;
  final int selectedDate;

  const AppState({
    this.status = LoadStatus.initial,
    this.data,
    this.query = '',
    this.filter = 'all',
    this.sort = 'name',
    this.error,
    this.selectedHour = 0,
    this.selectedDate = 0,
  });

  AppState copyWith({
    LoadStatus? status,
    AppData? data,
    String? query,
    String? filter,
    String? sort,
    String? error,
    int? selectedHour,
    int? selectedDate,
  }) => AppState(
    status: status ?? this.status,
    data: data ?? this.data,
    query: query ?? this.query,
    filter: filter ?? this.filter,
    sort: sort ?? this.sort,
    error: error,
    selectedHour: selectedHour ?? this.selectedHour,
    selectedDate: selectedDate ?? this.selectedDate,
  );

  List<Doctor> get visibleDoctors {
    var items = [...?data?.doctors];

    if (filter == 'favorites') {
      items = items.where((d) => d.isFavorite).toList();
    }

    if (query.trim().isNotEmpty) {
      final q = query.toLowerCase();
      items = items
          .where(
            (d) =>
                d.name.toLowerCase().contains(q) ||
                d.specialty.toLowerCase().contains(q),
          )
          .toList();
    }

    if (sort == 'name') items.sort((a, b) => a.name.compareTo(b.name));

    if (sort == 'specialty') {
      items.sort((a, b) => a.specialty.compareTo(b.specialty));
    }

    return items;
  }
}