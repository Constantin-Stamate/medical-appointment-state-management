import 'doctor.dart';

class AppData {
  final Map<String, dynamic> home;
  final Map<String, dynamic> details;
  final List<Doctor> doctors;
  final List<Map<String, dynamic>> services;

  const AppData({
    required this.home,
    required this.details,
    required this.doctors,
    required this.services,
  });

  AppData copyWithDoctors(List<Doctor> value) =>
      AppData(home: home, details: details, doctors: value, services: services);

  factory AppData.fromJson(Map<String, dynamic> json) {
    final home = Map<String, dynamic>.from(json['homeScreen'] as Map);
    return AppData(
      home: home,
      details: Map<String, dynamic>.from(json['appointmentDetails'] as Map),
      doctors: (home['nearbyDoctors'] as List)
          .map((e) => Doctor.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      services: (home['healthServices'] as List)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
    );
  }
}