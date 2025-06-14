import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Reports'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Your Uploaded Reports',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildReportCard('Blood Test Report', 'Uploaded on: April 30, 2025'),
                  _buildReportCard('Brain MRI Scan', 'Uploaded on: March 18, 2025'),
                  _buildReportCard('Prescription Document', 'Uploaded on: February 10, 2025'),
                  // ➕ Add more as needed
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Add upload functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Upload feature coming soon!")),
                );
              },
              icon: const Icon(Icons.cloud_upload),
              label: const Text("Upload New Report"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(String title, String subtitle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: const Icon(Icons.insert_drive_file, color: Colors.deepPurple, size: 32),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.visibility, color: Colors.grey),
        onTap: () {
          // TODO: Add view report functionality
        },
      ),
    );
  }
}
