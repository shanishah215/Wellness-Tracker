import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/extensions.dart';
import '../widgets/neo_card.dart';
import '../widgets/neo_button.dart';
import '../widgets/neo_text_field.dart';
import '../widgets/neo_background.dart';
import '../controllers/dashboard_controller.dart';
import '../../domain/entities/wellness_data.dart';

class AddEntryScreen extends StatelessWidget {
  const AddEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Add Entry"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: NeoBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.responsivePadding).copyWith(top: kToolbarHeight + 40),
          child: Column(
            children: [
              NeoCard(
              isGlass: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Enter Activity Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.scaled(18))),
                  24.vSpace,
                  const NeoTextField(
                    hintText: "Steps",
                    prefixIcon: Icons.directions_run,
                  ),
                  16.vSpace,
                  const NeoTextField(
                    hintText: "Water (L)",
                    prefixIcon: Icons.water_drop,
                  ),
                  16.vSpace,
                  const NeoTextField(
                    hintText: "Sleep (h)",
                    prefixIcon: Icons.bedtime,
                  ),
                  16.vSpace,
                  const NeoTextField(
                    hintText: "Calories",
                    prefixIcon: Icons.local_fire_department,
                  ),
                  24.vSpace,
                  NeoButton(
                    onPressed: () async {
                      final controller = Get.find<DashboardController>();
                      // Mocking data based on input or just a new entry
                      final newEntry = WellnessData(
                        steps: 1000, // In practice, read from text fields
                        waterIntake: 0.5,
                        sleepHours: 1.0,
                        caloriesBurned: 100,
                        date: DateTime.now(),
                      );
                      
                      await controller.addEntry(newEntry);
                      Get.back();
                      Get.snackbar("Success", "Entry added successfully!", 
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green.withOpacity(0.1),
                        colorText: Colors.green,
                      );
                    },
                    child: Center(child: Text("Add Activity", style: TextStyle(fontSize: context.scaled(16)))),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}
