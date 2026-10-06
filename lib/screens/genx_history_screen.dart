import 'package:flutter/material.dart';

import '../genx/genx_workout_storage.dart';

class GenXHistoryScreen extends StatelessWidget {
  const GenXHistoryScreen({super.key});

  String _formatDate(String value) {
    final date = DateTime.tryParse(value)?.toLocal();

    if (date == null) return value;

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout History'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: GenXWorkoutStorage.getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Unable to load workout history.',
                style: theme.textTheme.bodyLarge,
              ),
            );
          }

          final history = snapshot.data ?? [];

          if (history.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.history_rounded,
                      size: 64,
                      color: colors.onSurfaceVariant,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No workouts yet',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Complete your first workout and it will appear here.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: history.length,
            itemBuilder: (context, index) {
              final item = history[index];

              final workout = item['workout']?.toString() ?? 'Workout';
              final date = item['date']?.toString() ?? '';
              final exercises =
                  (item['exercises'] as List?)?.length ?? 0;

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: CircleAvatar(
                    backgroundColor: colors.primaryContainer,
                    child: Icon(
                      Icons.fitness_center_rounded,
                      color: colors.onPrimaryContainer,
                    ),
                  ),
                  title: Text(
                    workout,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      '${_formatDate(date)} • $exercises exercises completed',
                    ),
                  ),
                  trailing: const Icon(
                    Icons.chevron_right_rounded,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
