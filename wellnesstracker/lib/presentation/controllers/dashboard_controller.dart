import 'package:get/get.dart';
import '../../domain/entities/wellness_data.dart';
import '../../domain/repositories/wellness_repository.dart';

class DashboardController extends GetxController {
  final WellnessRepository repository;

  DashboardController({required this.repository});

  final Rx<WellnessData?> dailyData = Rx<WellnessData?>(null);
  final RxList<WellnessData> weeklyData = <WellnessData>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData({bool showLoading = true}) async {
    if (showLoading) isLoading.value = true;
    try {
      final newData = await repository.getDailyStats();
      final newWeekly = await repository.getWeeklyStats();
      
      // Update values which will trigger observers
      dailyData.value = newData;
      weeklyData.assignAll(newWeekly);
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch wellness data');
    } finally {
      if (showLoading) isLoading.value = false;
    }
  }

  Future<void> addEntry(WellnessData data) async {
    try {
      await repository.addEntry(data);
      // After adding, refresh data without a full screen loading indicator
      await fetchData(showLoading: false);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add entry');
    }
  }
}
