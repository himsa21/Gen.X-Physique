import 'package:flutter/material.dart';
import '../genx/genx_program.dart';
import 'genx_workout_screen.dart';
import 'genx_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final todayIndex = DateTime.now().weekday - 1;
    final todayWorkout = genXProgram[todayIndex];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'GEN.X PHYSIQUE',
                            style: theme.textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.8,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Build your physique.',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: colors.primaryContainer,
                      child: Icon(
                        Icons.person_outline_rounded,
                        color: colors.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              sliver: SliverToBoxAdapter(
                child: _TodayWorkoutCard(
                  colors: colors,
                  theme: theme,
                  workout: todayWorkout,
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'This Week',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverToBoxAdapter(
                child: _WeeklySplit(
                  colors: colors,
                  theme: theme,
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        title: 'Workouts',
                        value: '0',
                        subtitle: 'This week',
                        icon: Icons.fitness_center_rounded,
                        colors: colors,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        title: 'Streak',
                        value: '0',
                        subtitle: 'Days',
                        icon: Icons.local_fire_department_rounded,
                        colors: colors,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 12),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'Quick Access',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    _QuickAction(
                      icon: Icons.menu_book_rounded,
                      title: 'Exercise Library',
                      subtitle: 'Browse exercises and techniques',
                      colors: colors,
                    ),
                    const SizedBox(height: 10),
                    _QuickAction(
                      icon: Icons.history_rounded,
                      title: 'Workout History',
                      subtitle: 'Track your previous sessions',
                      colors: colors,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const GenXHistoryScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _QuickAction(
                      icon: Icons.insights_rounded,
                      title: 'Progress',
                      subtitle: 'Monitor your physique journey',
                      colors: colors,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TodayWorkoutCard extends StatelessWidget {
  const _TodayWorkoutCard({
    required this.colors,
    required this.theme,
    required this.workout,
  });

  final ColorScheme colors;
  final ThemeData theme;
  final GenXDay workout;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    workout.day.toUpperCase(),
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.calendar_today_rounded,
                  size: 18,
                  color: colors.onSurfaceVariant,
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              workout.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              workout.focus,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Icon(
                  Icons.fitness_center_rounded,
                  size: 18,
                  color: colors.primary,
                ),
                const SizedBox(width: 7),
                Text(
                  '${workout.exercises.length} exercises',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 18),
                Icon(
                  Icons.timer_outlined,
                  size: 18,
                  color: colors.primary,
                ),
                const SizedBox(width: 7),
                Text(
                  '~50 min',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => GenXWorkoutScreen(
                        workout: workout,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('START WORKOUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklySplit extends StatelessWidget {
  const _WeeklySplit({
    required this.colors,
    required this.theme,
  });

  final ColorScheme colors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    const days = [
      ('M', 'Legs', true),
      ('T', 'Back', false),
      ('W', 'Chest', false),
      ('T', 'Legs', false),
      ('F', 'Back', false),
      ('S', 'Chest', false),
      ('S', 'Rest', false),
    ];

    return Row(
      children: days.map((day) {
        final active = day.$3;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 19,
                  backgroundColor: active
                      ? colors.primary
                      : colors.surfaceContainerHighest,
                  child: Text(
                    day.$1,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: active
                          ? colors.onPrimary
                          : colors.onSurfaceVariant,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  day.$2,
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: active ? FontWeight.w800 : FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.colors,
  });

  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colors.primary),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.colors,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final ColorScheme colors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 5,
        ),
        leading: CircleAvatar(
          backgroundColor: colors.secondaryContainer,
          child: Icon(
            icon,
            color: colors.onSecondaryContainer,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
