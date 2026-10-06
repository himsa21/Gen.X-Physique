import 'package:flutter/material.dart';

import '../genx/genx_workout_storage.dart';

class GenXProgressScreen extends StatelessWidget {
  const GenXProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: GenXWorkoutStorage.getHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final history = snapshot.data ?? [];

          final totalWorkouts = history.length;

          final totalExercises = history.fold<int>(
            0,
            (sum, workout) =>
                sum + ((workout['exercises'] as List?)?.length ?? 0),
          );

          return ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Your Journey',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Build consistency. Track performance. Keep progressing.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: _ProgressCard(
                      icon: Icons.fitness_center_rounded,
                      value: '$totalWorkouts',
                      label: 'Workouts',
                      colors: colors,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _ProgressCard(
                      icon: Icons.check_circle_outline_rounded,
                      value: '$totalExercises',
                      label: 'Exercises',
                      colors: colors,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: colors.primaryContainer,
                        child: Icon(
                          Icons.trending_up_rounded,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Consistency',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              totalWorkouts == 0
                                  ? 'Complete your first workout to start tracking.'
                                  : 'Keep showing up and build your streak.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Recent Activity',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 12),

              if (history.isEmpty)
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'No workout activity yet.',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                )
              else
                ...history.take(5).map(
                  (workout) => Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: const Icon(
                        Icons.fitness_center_rounded,
                      ),
                      title: Text(
                        workout['workout']?.toString() ?? 'Workout',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        '${((workout['exercises'] as List?)?.length ?? 0)} exercises completed',
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.colors,
  });

  final IconData icon;
  final String value;
  final String label;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: colors.primary,
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
