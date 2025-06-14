import 'package:flutter/material.dart';

class DailyHealthEntryPage extends StatefulWidget {
  const DailyHealthEntryPage({super.key});

  @override
  State<DailyHealthEntryPage> createState() => _DailyHealthEntryPageState();
}

class _DailyHealthEntryPageState extends State<DailyHealthEntryPage> {
  String headacheLevel = '';
  Map<String, bool> waterIntake = {
    'Morning': false,
    'Afternoon': false,
    'Night': false,
  };
  Map<String, bool> foodTaken = {
    'Morning': false,
    'Afternoon': false,
    'Night': false,
  };
  Map<String, bool> foodDisabled = {
    'Morning': false,
    'Afternoon': false,
    'Night': false,
  };
  bool exerciseDone = false;
  Map<String, bool> medicinesTaken = {
    'Morning': false,
    'Afternoon': false,
    'Night': false,
  };

  void _handleFoodTap(String time, bool value) {
    if (!foodDisabled[time]!) {
      setState(() {
        foodTaken[time] = value;
        foodDisabled[time] = true;
      });
    }
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildHeadacheLevel() {
    final levels = ['No Pain', 'Low', 'Medium', 'High'];
    return Wrap(
      spacing: 10,
      children: levels.map((level) {
        return ChoiceChip(
          label: Text(level),
          selected: headacheLevel == level,
          onSelected: (selected) {
            setState(() {
              headacheLevel = level;
            });
          },
          selectedColor: Colors.deepPurpleAccent,
        );
      }).toList(),
    );
  }

  Widget _buildWaterIntake() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: waterIntake.keys.map((time) {
        return FilterChip(
          label: Text("$time\n2L", textAlign: TextAlign.center),
          selected: waterIntake[time]!,
          onSelected: (selected) {
            setState(() {
              waterIntake[time] = selected;
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildToggleButtons(Map<String, bool> data, String type,
      {required Function(String, bool)? onTap, Map<String, bool>? disabled}) {
    return Column(
      children: data.keys.map((time) {
        final isDisabled = disabled != null && disabled[time]!;
        return ListTile(
          title: Text("$type - $time"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: data[time]! ? Colors.green : Colors.grey,
                ),
                onPressed: isDisabled ? null : () => onTap!(time, true),
              ),
              IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: !data[time]! ? Colors.red : Colors.grey,
                ),
                onPressed: isDisabled ? null : () => onTap!(time, false),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExerciseToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Exercise Done: ", style: TextStyle(fontSize: 16)),
        Switch(
          value: exerciseDone,
          onChanged: (val) {
            setState(() {
              exerciseDone = val;
            });
          },
          activeColor: Colors.deepPurple,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Health Entry'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("🧠 Headache Level"),
            _buildHeadacheLevel(),

            _buildSectionTitle("💧 Water Intake"),
            _buildWaterIntake(),

            _buildSectionTitle("🍲 Food Intake"),
            _buildToggleButtons(foodTaken, "Food", onTap: _handleFoodTap, disabled: foodDisabled),

            _buildSectionTitle("🏃‍♀️ Exercise"),
            _buildExerciseToggle(),

            _buildSectionTitle("💊 Medicine Taken"),
            _buildToggleButtons(medicinesTaken, "Medicine", onTap: (time, value) {
              setState(() {
                medicinesTaken[time] = value;
              });
            }),

            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Data Submitted Successfully!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Submit", style: TextStyle(fontSize: 16)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
