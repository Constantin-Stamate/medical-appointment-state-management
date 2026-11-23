import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medical_appointment_state_management/models/app_data.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test(
    'original JSON provides doctors, services and remote media URLs',
    () async {
      final json = jsonDecode(
        await rootBundle.loadString('assets/data/lab_v2.json'),
      ) as Map<String, dynamic>;
      final data = AppData.fromJson(json);
      expect(data.doctors, isNotEmpty);
      expect(data.services, isNotEmpty);
      expect(
        data.services.every(
          (s) => (s['iconUrl'] as String).startsWith('https://'),
        ),
        isTrue,
      );
      expect(
        data.doctors.every((d) => d.avatarUrl.startsWith('https://')),
        isTrue,
      );
    },
  );
}