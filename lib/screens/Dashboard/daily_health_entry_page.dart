import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';

class DailyHealthEntryPage extends StatefulWidget {
  final String patientId;

  const DailyHealthEntryPage({super.key, required this.patientId});
=======

class DailyHealthEntryPage extends StatefulWidget {
  const DailyHealthEntryPage({super.key});
>>>>>>> ac42521

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
<<<<<<< HEAD
  bool _isLoading = false;
  bool _isExistingEntry = false;
  int? _existingEntryId;

  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _checkExistingEntry();
  }

  Future<void> _checkExistingEntry() async {
    setState(() => _isLoading = true);

    try {
      final now = DateTime.now().toLocal();
      final today = DateTime(now.year, now.month, now.day);
      final tomorrow = today.add(const Duration(days: 1));

      final response = await supabase
          .from('health_entries')
          .select()
          .eq('patient_id', widget.patientId)
          .gte('entry_date', today.toIso8601String())
          .lt('entry_date', tomorrow.toIso8601String())
          .maybeSingle();

      if (response != null) {
        setState(() {
          _isExistingEntry = true;
          _existingEntryId = response['id'];
          headacheLevel = response['headache_level']?.toString() ?? '';
          waterIntake = {
            'Morning': response['water_morning'] ?? false,
            'Afternoon': response['water_afternoon'] ?? false,
            'Night': response['water_night'] ?? false,
          };
          foodTaken = {
            'Morning': response['food_morning'] ?? false,
            'Afternoon': response['food_afternoon'] ?? false,
            'Night': response['food_night'] ?? false,
          };
          exerciseDone = response['exercise_done'] ?? false;
          medicinesTaken = {
            'Morning': response['medicine_morning'] ?? false,
            'Afternoon': response['medicine_afternoon'] ?? false,
            'Night': response['medicine_night'] ?? false,
          };
          foodDisabled = {
            'Morning': response['food_morning'] != null,
            'Afternoon': response['food_afternoon'] != null,
            'Night': response['food_night'] != null,
          };
        });
      } else {
        // Reset all fields for a new day
        setState(() {
          _isExistingEntry = false;
          _existingEntryId = null;
          headacheLevel = '';
          waterIntake = {
            'Morning': false,
            'Afternoon': false,
            'Night': false,
          };
          foodTaken = {
            'Morning': false,
            'Afternoon': false,
            'Night': false,
          };
          exerciseDone = false;
          medicinesTaken = {
            'Morning': false,
            'Afternoon': false,
            'Night': false,
          };
          foodDisabled = {
            'Morning': false,
            'Afternoon': false,
            'Night': false,
          };
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading existing data: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleFoodTap(String time, bool value) {
    setState(() {
      foodTaken[time] = value;
      if (!_isExistingEntry) {
        foodDisabled[time] = true;
      }
    });
  }

  Future<void> _submitData() async {
    setState(() => _isLoading = true);

    try {
      final now = DateTime.now().toLocal();
      final today = DateTime(now.year, now.month, now.day);

      final data = {
        'patient_id': widget.patientId,
        'entry_date': today.toIso8601String(),
        'headache_level': headacheLevel.isEmpty ? null : headacheLevel,
        'water_morning': waterIntake['Morning'],
        'water_afternoon': waterIntake['Afternoon'],
        'water_night': waterIntake['Night'],
        'food_morning': foodTaken['Morning'],
        'food_afternoon': foodTaken['Afternoon'],
        'food_night': foodTaken['Night'],
        'exercise_done': exerciseDone,
        'medicine_morning': medicinesTaken['Morning'],
        'medicine_afternoon': medicinesTaken['Afternoon'],
        'medicine_night': medicinesTaken['Night'],
      };

      if (_isExistingEntry && _existingEntryId != null) {
        await supabase
            .from('health_entries')
            .update(data)
            .eq('id', _existingEntryId!);
      } else {
        await supabase
            .from('health_entries')
            .insert(data);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data Submitted Successfully!")),
      );

      setState(() {
        if (!_isExistingEntry) {
          _isExistingEntry = true;
          foodDisabled = {
            'Morning': foodTaken['Morning'] != null,
            'Afternoon': foodTaken['Afternoon'] != null,
            'Night': foodTaken['Night'] != null,
          };
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting data: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
=======

  void _handleFoodTap(String time, bool value) {
    if (!foodDisabled[time]!) {
      setState(() {
        foodTaken[time] = value;
        foodDisabled[time] = true;
      });
>>>>>>> ac42521
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
<<<<<<< HEAD
              headacheLevel = selected ? level : '';
=======
              headacheLevel = level;
>>>>>>> ac42521
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
<<<<<<< HEAD
                  color: data[time]!
                      ? Colors.green
                      : isDisabled ? Colors.grey[300] : Colors.grey,
=======
                  color: data[time]! ? Colors.green : Colors.grey,
>>>>>>> ac42521
                ),
                onPressed: isDisabled ? null : () => onTap!(time, true),
              ),
              IconButton(
                icon: Icon(
                  Icons.cancel,
<<<<<<< HEAD
                  color: !data[time]!
                      ? Colors.red
                      : isDisabled ? Colors.grey[300] : Colors.grey,
                ),
                onPressed: isDisabled ? null : () => onTap!(time, false),
              ),
              if (isDisabled && _isExistingEntry)
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  onPressed: () {
                    setState(() {
                      foodDisabled[time] = false;
                    });
                  },
                ),
=======
                  color: !data[time]! ? Colors.red : Colors.grey,
                ),
                onPressed: isDisabled ? null : () => onTap!(time, false),
              ),
>>>>>>> ac42521
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
<<<<<<< HEAD
        const Text("Exercise Done: ", style: TextStyle(fontSize: 16)),
=======
        Text("Exercise Done: ", style: TextStyle(fontSize: 16)),
>>>>>>> ac42521
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
<<<<<<< HEAD
        title: Text(_isExistingEntry ? 'Update Daily Entry' : 'New Daily Entry'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
=======
        title: const Text('Daily Health Entry'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
>>>>>>> ac42521
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
<<<<<<< HEAD
            if (_isExistingEntry)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Updating existing entry for today',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),

=======
>>>>>>> ac42521
            _buildSectionTitle("🧠 Headache Level"),
            _buildHeadacheLevel(),

            _buildSectionTitle("💧 Water Intake"),
            _buildWaterIntake(),

            _buildSectionTitle("🍲 Food Intake"),
<<<<<<< HEAD
            _buildToggleButtons(foodTaken, "Food",
                onTap: _handleFoodTap, disabled: foodDisabled),
=======
            _buildToggleButtons(foodTaken, "Food", onTap: _handleFoodTap, disabled: foodDisabled),
>>>>>>> ac42521

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
<<<<<<< HEAD
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 15),
=======
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Data Submitted Successfully!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
>>>>>>> ac42521
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
<<<<<<< HEAD
}
=======
}
>>>>>>> ac42521
