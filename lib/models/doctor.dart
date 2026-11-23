class Doctor {
  final String id, name, specialty, distance, avatarUrl;
  final bool isFavorite;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.distance,
    required this.avatarUrl,
    this.isFavorite = false,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json['id'] as String,
    name: json['name'] as String,
    specialty: json['specialty'] as String,
    distance: json['distance'] as String,
    avatarUrl: json['avatarUrl'] as String,
    isFavorite: json['isFavorite'] as bool? ?? false,
  );

  Doctor copyWith({bool? isFavorite}) => Doctor(
    id: id,
    name: name,
    specialty: specialty,
    distance: distance,
    avatarUrl: avatarUrl,
    isFavorite: isFavorite ?? this.isFavorite,
  );
}