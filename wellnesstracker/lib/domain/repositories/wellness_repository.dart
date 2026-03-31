import '../entities/wellness_data.dart';

abstract class WellnessRepository {
  Future<WellnessData> getDailyStats();
  Future<List<WellnessData>> getWeeklyStats();
  Future<void> addEntry(WellnessData data);
}
