import '../../domain/entities/wellness_data.dart';
import '../../domain/repositories/wellness_repository.dart';

class MockWellnessDataSource implements WellnessRepository {
  int _steps = 7540;

  @override
  Future<WellnessData> getDailyStats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return WellnessData(
      steps: _steps,
      waterIntake: 2.1,
      sleepHours: 6.5,
      caloriesBurned: 1850,
      date: DateTime.now(),
    );
  }

  @override
  Future<List<WellnessData>> getWeeklyStats() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.generate(7, (index) {
      return WellnessData(
        steps: 6000 + (index * 500),
        waterIntake: 1.5 + (index * 0.2),
        sleepHours: 6.0 + (index * 0.3),
        caloriesBurned: 1500 + (index * 100),
        date: DateTime.now().subtract(Duration(days: 6 - index)),
      );
    });
  }

  @override
  Future<void> addEntry(WellnessData data) async {
    await Future.delayed(const Duration(seconds: 1));
    _steps += data.steps;
    // In a real app, this would save to local DB or API
  }
}
