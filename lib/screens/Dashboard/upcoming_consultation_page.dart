import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';

class UpcomingConsultationPage extends StatefulWidget {
  final int patientId;

  const UpcomingConsultationPage({
    super.key,
    required this.patientId,
  });

  @override
  State<UpcomingConsultationPage> createState() => _UpcomingConsultationPageState();
}

class _UpcomingConsultationPageState extends State<UpcomingConsultationPage> {
  final supabase = Supabase.instance.client;
  Map<String, dynamic>? upcomingAppointment;
  bool isLoading = true;
  String errorMessage = '';
  int? patientId;

  @override
  void initState() {
    super.initState();
    _initializeAndFetch();
  }

  Future<void> _initializeAndFetch() async {
    try {
      patientId = widget.patientId;
      debugPrint('Using patient ID from constructor: $patientId');

      if (patientId == null || patientId == 0) {
        setState(() {
          errorMessage = 'Invalid patient ID.';
          isLoading = false;
        });
        return;
      }

      await _fetchUpcomingAppointment();
    } catch (e) {
      setState(() {
        errorMessage = 'Error initializing: ${e.toString()}';
        isLoading = false;
      });
      debugPrint('Initialization error: $e');
    }
  }

  Future<void> _fetchUpcomingAppointment() async {
    try {
      final response = await supabase
          .from('appointments')
          .select()
          .eq('patient_id', patientId!)
          .eq('status', 'Scheduled')
          .gte('appointment_date', DateTime.now().toIso8601String().split('T')[0])
          .order('appointment_date', ascending: true)
          .order('appointment_time', ascending: true)
          .limit(1);

      if (response.isNotEmpty) {
        setState(() {
          upcomingAppointment = response[0];
          isLoading = false;
        });
        debugPrint('Found appointment: $upcomingAppointment');
      } else {
        setState(() {
          upcomingAppointment = null;
          isLoading = false;
        });
        debugPrint('No upcoming appointments found');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to fetch appointment: ${e.toString()}';
        isLoading = false;
      });
      debugPrint('Appointment fetch error: $e');
    }
  }

  String _formatAppointmentDate(String dateString) {
    final date = DateTime.parse(dateString);
    return '${_getDayName(date.weekday)}, ${date.day} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getDayName(int weekday) {
    const days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return days[weekday % 7];
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
=======

class UpcomingConsultationPage extends StatelessWidget {
  const UpcomingConsultationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated consultation date; replace with actual data fetching logic
    final String? consultationDate = null; // e.g., 'May 10, 2025'

>>>>>>> ac42521
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upcoming Consultation"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.deepPurple[50],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.shade100,
                  blurRadius: 8,
                  offset: const Offset(2, 4),
<<<<<<< HEAD
                )
              ],
            ),
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.deepPurple)
                : errorMessage.isNotEmpty
                ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 20),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      errorMessage = '';
                    });
                    _initializeAndFetch();
                  },
                  child: const Text('Retry'),
                ),
              ],
            )
                : Column(
=======
                ),
              ],
            ),
            child: Column(
>>>>>>> ac42521
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today, size: 60, color: Colors.deepPurple),
                const SizedBox(height: 20),
<<<<<<< HEAD
                if (upcomingAppointment != null) ...[
                  const Text(
                    "Next Consultation:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow("Date:", _formatAppointmentDate(upcomingAppointment!['appointment_date'])),
                  _buildDetailRow("Day:", upcomingAppointment!['day']),
                  _buildDetailRow("Time:", upcomingAppointment!['appointment_time']),
                  _buildDetailRow("Reason:", upcomingAppointment!['reason']),
                ] else
                  const Text(
                    "No upcoming appointments scheduled.",
                    style: TextStyle(fontSize: 18, color: Colors.deepPurple),
                  ),
=======
                Text(
                  consultationDate != null
                      ? "Next Consultation Date:\n$consultationDate"
                      : "Date will be announced soon.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
>>>>>>> ac42521
              ],
            ),
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
=======
>>>>>>> ac42521
}
