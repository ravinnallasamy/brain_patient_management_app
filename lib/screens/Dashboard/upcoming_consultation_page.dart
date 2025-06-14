import 'package:flutter/material.dart';

class UpcomingConsultationPage extends StatelessWidget {
  const UpcomingConsultationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated consultation date; replace with actual data fetching logic
    final String? consultationDate = null; // e.g., 'May 10, 2025'

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
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today, size: 60, color: Colors.deepPurple),
                const SizedBox(height: 20),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
