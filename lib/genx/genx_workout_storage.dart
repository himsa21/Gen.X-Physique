import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GenXWorkoutStorage {
  static const _historyKey = 'genx_workout_history';

  static Future<void> saveWorkout({
    required String workoutName,
    required List<Map<String, dynamic>> exercises,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final history = prefs.getStringList(_historyKey) ?? [];

    history.add(
      jsonEncode({
        'date': DateTime.now().toIso8601String(),
        'workout': workoutName,
        'exercises': exercises,
      }),
    );

    await prefs.setStringList(_historyKey, history);
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();

    final history = prefs.getStringList(_historyKey) ?? [];

    return history
        .map(
          (item) =>
              jsonDecode(item) as Map<String, dynamic>,
        )
        .toList()
        .reversed
        .toList();
  }
}
