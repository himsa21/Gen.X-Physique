class GenXDay {
  const GenXDay({
    required this.day,
    required this.title,
    required this.focus,
    required this.exercises,
  });

  final String day;
  final String title;
  final String focus;
  final List<GenXExercise> exercises;
}

class GenXExercise {
  const GenXExercise({
    required this.name,
    required this.sets,
    required this.reps,
  });

  final String name;
  final int sets;
  final String reps;
}

const genXProgram = <GenXDay>[
  GenXDay(
    day: 'Monday',
    title: 'Legs + Shoulders',
    focus: 'Lower body + shoulder width',
    exercises: [
      GenXExercise(name: 'Leg Press', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Romanian Deadlift', sets: 3, reps: '8–10'),
      GenXExercise(name: 'Leg Extension', sets: 3, reps: '10–15'),
      GenXExercise(name: 'Standing Calf Raise', sets: 3, reps: '10–15'),
      GenXExercise(name: 'Machine Shoulder Press', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Lateral Raise', sets: 3, reps: '12–15'),
      GenXExercise(name: 'Rear Delt Fly', sets: 3, reps: '12–15'),
    ],
  ),
  GenXDay(
    day: 'Tuesday',
    title: 'Back + Biceps',
    focus: 'Back width + thickness',
    exercises: [
      GenXExercise(name: 'Lat Pulldown', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Chest-Supported Row', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Seated Cable Row', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Straight-Arm Pulldown', sets: 2, reps: '12–15'),
      GenXExercise(name: 'Preacher Curl', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Hammer Curl', sets: 3, reps: '10–12'),
    ],
  ),
  GenXDay(
    day: 'Wednesday',
    title: 'Chest + Triceps + Abs',
    focus: 'Chest development + core',
    exercises: [
      GenXExercise(name: 'Machine Chest Press', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Incline Dumbbell Press', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Cable Fly', sets: 3, reps: '12–15'),
      GenXExercise(name: 'Rope Pushdown', sets: 3, reps: '10–15'),
      GenXExercise(name: 'Overhead Cable Extension', sets: 3, reps: '10–15'),
      GenXExercise(name: 'Cable Crunch', sets: 3, reps: '10–15'),
      GenXExercise(name: 'Reverse Crunch', sets: 3, reps: '10–15'),
    ],
  ),
  GenXDay(
    day: 'Thursday',
    title: 'Legs + Shoulders',
    focus: 'Lower body + delts',
    exercises: [
      GenXExercise(name: 'Leg Press', sets: 3, reps: '10–12'),
      GenXExercise(name: 'Romanian Deadlift', sets: 3, reps: '8–10'),
      GenXExercise(name: 'Leg Extension', sets: 3, reps: '12–15'),
      GenXExercise(name: 'Standing Calf Raise', sets: 3, reps: '12–15'),
      GenXExercise(name: 'Machine Shoulder Press', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Lateral Raise', sets: 3, reps: '12–15'),
      GenXExercise(name: 'Rear Delt Fly', sets: 3, reps: '12–15'),
    ],
  ),
  GenXDay(
    day: 'Friday',
    title: 'Back + Biceps',
    focus: 'Back width + arms',
    exercises: [
      GenXExercise(name: 'Lat Pulldown', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Chest-Supported Row', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Seated Cable Row', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Straight-Arm Pulldown', sets: 2, reps: '12–15'),
      GenXExercise(name: 'Barbell Curl', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Hammer Curl', sets: 3, reps: '10–12'),
    ],
  ),
  GenXDay(
    day: 'Saturday',
    title: 'Chest + Triceps + Abs',
    focus: 'Chest + arms + core',
    exercises: [
      GenXExercise(name: 'Incline Chest Press', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Machine Chest Press', sets: 3, reps: '8–12'),
      GenXExercise(name: 'Pec Deck Fly', sets: 3, reps: '12–15'),
      GenXExercise(name: 'Rope Pushdown', sets: 3, reps: '10–15'),
      GenXExercise(name: 'Single-Arm Cable Extension', sets: 3, reps: '10–15'),
      GenXExercise(name: 'Cable Crunch', sets: 3, reps: '10–15'),
      GenXExercise(name: 'Hanging Knee Raise', sets: 3, reps: '10–15'),
    ],
  ),
  GenXDay(
    day: 'Sunday',
    title: 'Rest',
    focus: 'Recovery',
    exercises: [],
  ),
];
