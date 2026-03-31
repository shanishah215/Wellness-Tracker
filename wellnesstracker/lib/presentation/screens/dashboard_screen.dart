import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/extensions.dart';
import '../widgets/neo_card.dart';
import '../widgets/neo_button.dart';
import '../widgets/neo_progress_bar.dart';
import '../controllers/dashboard_controller.dart';
import 'activity_detail_screen.dart';
import 'add_entry_screen.dart';

import '../widgets/neo_background.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();

    return Scaffold(
      body: NeoBackground(
        child: Obx(() {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
            child: controller.isLoading.value 
              ? const Center(key: ValueKey('loading'), child: CircularProgressIndicator())
              : SafeArea(
                key: ValueKey(controller.dailyData.value?.steps ?? 0),
                child: CustomScrollView(
                  slivers: [
                    _buildAppBar(context),
                    SliverPadding(
                      padding: EdgeInsets.all(context.responsivePadding),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(context),
                            24.vSpace,
                            _buildMainCircularProgress(context, controller.dailyData.value),
                            32.vSpace,
                            _buildMetricsGrid(context, controller.dailyData.value),
                            32.vSpace,
                            _buildWeeklyProgressChart(context, controller.weeklyData),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        );
      }),
      ),
      floatingActionButton: NeoButton(
        onPressed: () => Get.to(() => const AddEntryScreen()),
        borderRadius: 50,
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Get.isDarkMode 
              ? Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1)
              : null,
          ),
          child: Icon(
            Icons.add, 
            color: Theme.of(context).primaryColor, 
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      floating: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        "Wellness Tracker",
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Get.changeThemeMode(
            Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
          ),
          icon: Icon(
            Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's Overview",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          "Stay consistent, stay healthy!",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  Widget _buildMainCircularProgress(BuildContext context, dynamic data) {
    return Center(
      child: NeoCircularProgress(
        progress: data.stepsProgress,
        size: context.scaled(220),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Theme.of(context).primaryColor, Colors.blueAccent],
              ).createShader(bounds),
              child: Text(
                "${data.steps}",
                style: TextStyle(
                  fontSize: context.scaled(36),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text("STEPS", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, letterSpacing: 1.2, fontSize: context.scaled(12))),
            Transform.translate(
              offset: Offset(0, context.scaled(5)),
              child: Text(
                "Goal: ${((data.steps / data.stepsProgress) / 1000).toStringAsFixed(0)}k", 
                style: TextStyle(fontSize: context.scaled(12), color: Colors.grey, fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context, dynamic data) {
    // For smaller tablets, 3 is too cramped. Use 2 if width < 600.
    final crossAxisCount = (context.screenWidth > 450 && context.screenWidth < 600) 
        ? 2 
        : context.gridCrossAxisCount.toInt();
    
    // Fix aspect ratio specifically for tablet to avoid tall overflow.
    double aspectRatio = 1.1;
    if (context.isNeoMobile) {
      aspectRatio = 0.9;
    } else if (context.isNeoTablet) {
      // For narrow tablets using 2 columns, they need more vertical space
      aspectRatio = crossAxisCount == 2 ? 0.95 : 1.2;
    }

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: crossAxisCount,
      crossAxisSpacing: context.scaled(20).clamp(10.0, 30.0),
      mainAxisSpacing: context.scaled(20).clamp(10.0, 30.0),
      childAspectRatio: aspectRatio,
      children: [
        _buildMetricCard(
          context,
          "Water",
          "${data.waterIntake}L",
          data.waterProgress,
          Icons.water_drop,
          Colors.blue,
        ),
        _buildMetricCard(
          context,
          "Sleep",
          "${data.sleepHours}h",
          data.sleepProgress,
          Icons.bedtime,
          Colors.orange,
        ),
        _buildMetricCard(
          context,
          "Calories",
          "${data.caloriesBurned}",
          data.caloriesProgress,
          Icons.local_fire_department,
          Colors.red,
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String label,
    String value,
    double progress,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => Get.to(() => ActivityDetailScreen(title: label, progress: progress, value: value, color: color, icon: icon)),
      child: NeoCard(
        isGlass: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(context.scaled(8)),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(context.scaled(10)),
              ),
              child: Icon(icon, color: color, size: context.scaled(28)),
            ),
            const Spacer(),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value, 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: context.scaled(22), letterSpacing: -0.5),
              ),
            ),
            Text(
              label.toUpperCase(), 
              style: TextStyle(color: Colors.grey.shade600, fontSize: context.scaled(10), fontWeight: FontWeight.w900, letterSpacing: 1.1),
            ),
            12.vSpace,
            NeoProgressBar(progress: progress, color: color, height: context.scaled(8)),
            4.vSpace,
            _buildInformativeText(context, progress),
          ],
        ),
      ),
    );
  }

  Widget _buildInformativeText(BuildContext context, double progress) {
    String text = "${(progress * 100).toStringAsFixed(0)}% achieved";
    return Text(
      text,
      style: TextStyle(fontSize: context.scaled(9), color: Colors.grey, fontStyle: FontStyle.italic),
    );
  }

  Widget _buildWeeklyProgressChart(BuildContext context, List<dynamic> weeklyData) {
    return NeoCard(
      isGlass: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("WEEKLY PERFORMANCE", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2, fontSize: context.scaled(12))),
              Text("Avg: 7.2k", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: context.scaled(10), fontWeight: FontWeight.bold)),
            ],
          ),
          24.vSpace,
          SizedBox(
            height: context.scaled(150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: weeklyData.map((data) {
                final barHeight = (context.scaled(120) * data.stepsProgress).toDouble();
                final isToday = data.date.day == DateTime.now().day;
                
                return Column(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            width: context.scaled(16),
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(context.scaled(8)),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.elasticOut,
                            height: barHeight,
                            width: context.scaled(16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: isToday 
                                  ? [Colors.orange, Colors.redAccent]
                                  : [Theme.of(context).primaryColor.withValues(alpha: 0.8), Theme.of(context).primaryColor],
                              ),
                              borderRadius: BorderRadius.circular(context.scaled(8)),
                              boxShadow: isToday ? [
                                BoxShadow(
                                  color: Colors.orange.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                )
                              ] : [],
                            ),
                          ),
                        ],
                      ),
                    ),
                    8.vSpace,
                    Text(
                      _getWeekdayShort(data.date),
                      style: TextStyle(
                        fontSize: context.scaled(10), 
                        color: isToday ? Theme.of(context).primaryColor : Colors.grey,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }


  String _getWeekdayShort(DateTime date) {
    const days = ["M", "T", "W", "T", "F", "S", "S"];
    return days[date.weekday - 1];
  }
}
