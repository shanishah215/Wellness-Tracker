class WellnessData {
  final int steps;
  final double waterIntake; // in Liters
  final double sleepHours;
  final int caloriesBurned;
  final DateTime date;

  WellnessData({
    required this.steps,
    required this.waterIntake,
    required this.sleepHours,
    required this.caloriesBurned,
    required this.date,
  });

  // For linear progress calculation (Mock goals)
  double get stepsProgress => (steps / 10000).clamp(0.0, 1.0);
  double get waterProgress => (waterIntake / 3.0).clamp(0.0, 1.0);
  double get sleepProgress => (sleepHours / 8.0).clamp(0.0, 1.0);
  double get caloriesProgress => (caloriesBurned / 2500).clamp(0.0, 1.0);
}
