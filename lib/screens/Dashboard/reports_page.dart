import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart'; // Add this import
import 'package:url_launcher/url_launcher.dart';

class ReportsPage extends StatefulWidget {
  final int patientId;

  const ReportsPage({
    super.key,
    required this.patientId,
  });

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final SupabaseClient _supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _reports = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await _supabase
          .from('reports')
          .select()
          .eq('patient_id', widget.patientId)
          .order('uploaded_at', ascending: false);

      if (response.isNotEmpty) {
        setState(() {
          _reports = List<Map<String, dynamic>>.from(response);
        });
      } else {
        setState(() {
          _errorMessage = 'No reports found for this patient';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading reports: ${e.toString()}';
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _viewReport(Map<String, dynamic> report) async {
    final fileUrl = report['file_url'] as String?;

    if (fileUrl == null || fileUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No file available for this report')),
      );
      return;
    }

    try {
      final uri = Uri.parse(fileUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception("Could not launch file URL");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error viewing report: ${e.toString()}')),
      );
    }
  }

  Widget _getFileIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return const Icon(Icons.picture_as_pdf, color: Colors.red, size: 32);
      case 'jpg':
      case 'jpeg':
      case 'png':
        return const Icon(Icons.image, color: Colors.blue, size: 32);
      case 'doc':
      case 'docx':
        return const Icon(Icons.description, color: Colors.blue, size: 32);
      default:
        return const Icon(Icons.insert_drive_file, color: Colors.grey, size: 32);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Reports'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(
        child: Text(
          _errorMessage,
          style: const TextStyle(fontSize: 18, color: Colors.red),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Your Medical Reports',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _reports.length,
                itemBuilder: (context, index) {
                  final report = _reports[index];
                  final uploadedAt = DateTime.parse(
                      report['uploaded_at'] ?? DateTime.now().toIso8601String());
                  final formattedDate = DateFormat('MMM dd, yyyy').format(uploadedAt);
                  final fileType = (report['file_type'] as String? ?? 'pdf').toLowerCase();

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: _getFileIcon(fileType),
                      title: Text(
                        report['description'] ?? 'Untitled Report',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(report['file_name'] ?? 'Unknown file'),
                          Text('Uploaded on: $formattedDate'),
                        ],
                      ),
                      trailing: const Icon(Icons.visibility, color: Colors.grey),
                      onTap: () => _viewReport(report),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Upload feature coming soon!")),
                );
              },
              icon: const Icon(Icons.cloud_upload),
              label: const Text("Upload New Report"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}