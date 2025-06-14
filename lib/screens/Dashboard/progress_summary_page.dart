import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class ProgressSummaryPage extends StatefulWidget {
  final dynamic patientId;  // Change from String to dynamic

  const ProgressSummaryPage({
    super.key,
    required this.patientId,
  });

  @override
  State<ProgressSummaryPage> createState() => _ProgressSummaryPageState();
}

class _ProgressSummaryPageState extends State<ProgressSummaryPage> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _healthData = [];
  bool _isLoading = true;
  String _errorMessage = '';
  late TooltipBehavior _tooltipBehavior;
  DateTimeRange? _dateRange;

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _dateRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 30)),
      end: DateTime.now(),
    );
    _loadHealthData();
  }

  Future<void> _loadHealthData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await _supabase
          .from('health_entries')
          .select()
          .eq('patient_id', widget.patientId)
          .gte('entry_date', _dateRange!.start.toIso8601String())
          .lte('entry_date', _dateRange!.end.toIso8601String())
          .order('entry_date', ascending: true);

      if (response.isNotEmpty) {
        setState(() {
          _healthData = List<Map<String, dynamic>>.from(response);
        });
      } else {
        setState(() {
          _errorMessage = 'No health data available for selected period';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load health data: ${e.toString()}';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: _dateRange,
    );

    if (picked != null && picked != _dateRange) {
      setState(() {
        _dateRange = picked;
      });
      await _loadHealthData();
    }
  }

  List<ChartData> _getHeadacheData() {
    return _healthData.where((entry) => entry['headache_level'] != null).map((entry) {
      final headacheLevel = double.tryParse(entry['headache_level'].toString()) ?? 0;
      return ChartData(
        date: DateFormat('MMM dd').format(DateTime.parse(entry['entry_date'])),
        value: headacheLevel,
        color: _getHeadacheColor(headacheLevel),
      );
    }).toList();
  }

  Color _getHeadacheColor(double level) {
    if (level >= 7) return Colors.red;
    if (level >= 4) return Colors.orange;
    return Colors.green;
  }

  double _calculateHydrationPercentage(Map<String, dynamic> entry) {
    int count = 0;
    if (entry['water_morning'] == true) count++;
    if (entry['water_afternoon'] == true) count++;
    if (entry['water_night'] == true) count++;
    return (count / 3) * 100;
  }

  double _calculateNutritionPercentage(Map<String, dynamic> entry) {
    int count = 0;
    if (entry['food_morning'] == true) count++;
    if (entry['food_afternoon'] == true) count++;
    if (entry['food_night'] == true) count++;
    return (count / 3) * 100;
  }

  double _calculateMedicationPercentage(Map<String, dynamic> entry) {
    int count = 0;
    if (entry['medicine_morning'] == true) count++;
    if (entry['medicine_afternoon'] == true) count++;
    if (entry['medicine_night'] == true) count++;
    return (count / 3) * 100;
  }

  Widget _buildDateRangeSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDateRange(context),
          ),
          Text(
            '${DateFormat('MMM d').format(_dateRange!.start)} - ${DateFormat('MMM d, y').format(_dateRange!.end)}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection({
    required String title,
    required String description,
    required List<ChartData> data,
    required String yAxisTitle,
    bool isPercentage = false,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              description,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: isPercentage ? 100 : 10,
                  title: AxisTitle(text: yAxisTitle),
                ),
                series: <CartesianSeries<ChartData, String>>[
                  ColumnSeries<ChartData, String>(
                    dataSource: data,
                    xValueMapper: (ChartData data, _) => data.date,
                    yValueMapper: (ChartData data, _) => data.value,
                    pointColorMapper: (ChartData data, _) => data.color,
                    width: 0.6,
                    spacing: 0.2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComplianceSection({
    required String title,
    required List<double> data,
    Color lineColor = Colors.blue,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 250,
              child: SfCartesianChart(
                tooltipBehavior: _tooltipBehavior,
                primaryXAxis: CategoryAxis(),
                primaryYAxis: NumericAxis(
                  minimum: 0,
                  maximum: 100,
                  title: AxisTitle(text: "Compliance %"),
                ),
                series: <CartesianSeries<double, String>>[
                  LineSeries<double, String>(
                    dataSource: data,
                    xValueMapper: (double value, int index) =>
                        DateFormat('MMM dd').format(DateTime.parse(_healthData[index]['entry_date'])),
                    yValueMapper: (double value, _) => value,
                    markerSettings: const MarkerSettings(isVisible: true),
                    color: lineColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBooleanChart({
    required String title,
    required List<bool> data,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                series: <CartesianSeries<bool, String>>[
                  ColumnSeries<bool, String>(
                    dataSource: data,
                    xValueMapper: (bool value, int index) =>
                        DateFormat('MMM dd').format(DateTime.parse(_healthData[index]['entry_date'])),
                    yValueMapper: (bool value, _) => value ? 1 : 0,
                    pointColorMapper: (bool value, _) =>
                    value ? Colors.green : Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  color: Colors.green,
                  margin: const EdgeInsets.only(right: 4),
                ),
                const Text("Completed"),
                const SizedBox(width: 16),
                Container(
                  width: 12,
                  height: 12,
                  color: Colors.red,
                  margin: const EdgeInsets.only(right: 4),
                ),
                const Text("Missed"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recent Health Entries",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text("Date")),
                  DataColumn(label: Text("Headache")),
                  DataColumn(label: Text("Hydration")),
                  DataColumn(label: Text("Nutrition")),
                  DataColumn(label: Text("Exercise")),
                  DataColumn(label: Text("Medication")),
                ],
                rows: _healthData.reversed.take(5).map((entry) {
                  return DataRow(cells: [
                    DataCell(Text(DateFormat('MMM dd').format(
                        DateTime.parse(entry['entry_date'])))),
                    DataCell(Text(entry['headache_level']?.toString() ?? '-')),
                    DataCell(Text(
                        '${_calculateHydrationPercentage(entry).toStringAsFixed(0)}%')),
                    DataCell(Text(
                        '${_calculateNutritionPercentage(entry).toStringAsFixed(0)}%')),
                    DataCell(Icon(
                      entry['exercise_done'] == true
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: entry['exercise_done'] == true
                          ? Colors.green
                          : Colors.red,
                    )),
                    DataCell(Text(
                        '${_calculateMedicationPercentage(entry).toStringAsFixed(0)}%')),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStats() {
    if (_healthData.isEmpty) return const SizedBox();

    final latestEntry = _healthData.last;
    final headache = latestEntry['headache_level'] ?? 'No data';
    final hydration = _calculateHydrationPercentage(latestEntry);
    final nutrition = _calculateNutritionPercentage(latestEntry);
    final medication = _calculateMedicationPercentage(latestEntry);
    final exercise = latestEntry['exercise_done'] == true ? 'Yes' : 'No';

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Today's Summary",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Table(
              children: [
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Headache Level"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(headache.toString()),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Hydration"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("${hydration.toStringAsFixed(0)}%"),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Nutrition"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("${nutrition.toStringAsFixed(0)}%"),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Medication"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text("${medication.toStringAsFixed(0)}%"),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Exercise"),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(exercise),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health Progress Summary"),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadHealthData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDateRangeSelector(),
            if (_healthData.isNotEmpty) _buildSummaryStats(),
            if (_healthData.any((e) => e['headache_level'] != null))
              _buildChartSection(
                title: "Headache Level",
                description: "Daily headache intensity (0-10 scale)",
                data: _getHeadacheData(),
                yAxisTitle: "Headache Level",
                isPercentage: false,
              ),
            _buildComplianceSection(
              title: "Hydration Compliance",
              data: _healthData
                  .map((entry) => _calculateHydrationPercentage(entry))
                  .toList(),
              lineColor: Colors.blue,
            ),
            _buildComplianceSection(
              title: "Nutrition Compliance",
              data: _healthData
                  .map((entry) => _calculateNutritionPercentage(entry))
                  .toList(),
              lineColor: Colors.orange,
            ),
            _buildComplianceSection(
              title: "Medication Compliance",
              data: _healthData
                  .map((entry) => _calculateMedicationPercentage(entry))
                  .toList(),
              lineColor: Colors.purple,
            ),
            _buildBooleanChart(
              title: "Exercise Routine",
              data: _healthData
                  .map((entry) => entry['exercise_done'] == true)
                  .toList(),
            ),
            _buildDataTable(),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String date;
  final double value;
  final Color color;

  ChartData({
    required this.date,
    required this.value,
    required this.color,
  });
}