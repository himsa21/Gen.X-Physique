import 'package:flutter/material.dart';

import '../genx/genx_program.dart';
import '../genx/genx_workout_storage.dart';

class GenXWorkoutScreen extends StatefulWidget {
  const GenXWorkoutScreen({
    super.key,
    required this.workout,
  });

  final GenXDay workout;

  @override
  State<GenXWorkoutScreen> createState() => _GenXWorkoutScreenState();
}

class _GenXWorkoutScreenState extends State<GenXWorkoutScreen> {
  late final List<bool> completed;
  late final List<TextEditingController> weights;

  @override
  void initState() {
    super.initState();

    completed = List<bool>.filled(
      widget.workout.exercises.length,
      false,
    );

    weights = List.generate(
      widget.workout.exercises.length,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (final controller in weights) {
      controller.dispose();
    }

    super.dispose();
  }

  int get completedCount =>
      completed.where((value) => value).length;

  double get progress {
    if (completed.isEmpty) return 0;
    return completedCount / completed.length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout.title),
      ),
      body: widget.workout.exercises.isEmpty
          ? const Center(
              child: Text('Rest day — recover and prepare for tomorrow.'),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '$completedCount/${completed.length} exercises',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Text(
                            '${(progress * 100).round()}%',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: colors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                    itemCount: widget.workout.exercises.length,
                    itemBuilder: (context, index) {
                      final exercise = widget.workout.exercises[index];

                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          exercise.name,
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          '${exercise.sets} sets × ${exercise.reps}',
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: colors.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Checkbox(
                                    value: completed[index],
                                    onChanged: (value) {
                                      setState(() {
                                        completed[index] = value ?? false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              TextField(
                                controller: weights[index],
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Weight',
                                  suffixText: 'kg',
                                  prefixIcon: const Icon(
                                    Icons.monitor_weight_outlined,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: completedCount == 0
                            ? null
                            : () async {
                                final exercises = <Map<String, dynamic>>[];

                                for (var i = 0;
                                    i < widget.workout.exercises.length;
                                    i++) {
                                  if (!completed[i]) continue;

                                  exercises.add({
                                    'name': widget.workout.exercises[i].name,
                                    'sets': widget.workout.exercises[i].sets,
                                    'reps': widget.workout.exercises[i].reps,
                                    'weight': weights[i].text.trim(),
                                  });
                                }

                                await GenXWorkoutStorage.saveWorkout(
                                  workoutName: widget.workout.title,
                                  exercises: exercises,
                                );

                                if (!mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Workout saved successfully.',
                                    ),
                                  ),
                                );

                                Navigator.of(context).pop();
                              },
                        icon: const Icon(Icons.check_rounded),
                        label: const Text('FINISH WORKOUT'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
