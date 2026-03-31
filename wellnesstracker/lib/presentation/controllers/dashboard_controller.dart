import 'package:get/get.dart';
import '../../domain/entities/wellness_data.dart';
import '../../domain/repositories/wellness_repository.dart';

/// Manages the state and business logic for the dashboard.
class DashboardController extends GetxController {
  final WellnessRepository repository;

  DashboardController({required this.repository});

  /// The most recent daily wellness data.
  final Rx<WellnessData?> dailyData = Rx<WellnessData?>(null);

  /// A list of wellness data for the current week.
  final RxList<WellnessData> weeklyData = <WellnessData>[].obs;

  /// Indicates if the controller is currently fetching data.
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  /// Fetches daily and weekly stats from the repository.
  /// Set [showLoading] to true for full-screen loading, false for background updates.
  Future<void> fetchData({bool showLoading = true}) async {
    if (showLoading) isLoading.value = true;
    try {
      final newData = await repository.getDailyStats();
      final newWeekly = await repository.getWeeklyStats();
      
      dailyData.value = newData;
      weeklyData.assignAll(newWeekly);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch wellness data');
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }

  /// Adds a new wellness entry and refreshes the dashboard.
  Future<void> addEntry(WellnessData data) async {
    try {
      await repository.addEntry(data);
      await fetchData(showLoading: false);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add entry');
    }
  }
}
