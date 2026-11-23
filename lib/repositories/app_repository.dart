import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/app_data.dart';

class AppRepository {
  Future<AppData> loadAppData() async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final source = await rootBundle.loadString('assets/data/lab_v2.json');
    final decoded = jsonDecode(source) as Map<String, dynamic>;
    return AppData.fromJson(decoded);
  }
}