import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Support"),
          backgroundColor: Colors.deepPurple,
          bottom: const TabBar(
            tabs: [
              Tab(text: "App Support"),
              Tab(text: "Doctor Support"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ApplicationSupportTab(),
            DoctorSupportTab(),
          ],
        ),
      ),
    );
  }
}

class ApplicationSupportTab extends StatelessWidget {
  const ApplicationSupportTab({super.key});

  // Method to fetch contact info from the database
  Future<Map<String, String>> fetchContactInfo() async {
    try {
      final response = await http.get(
        Uri.parse('YOUR_API_ENDPOINT/contact_info?type=application_support'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final Map<String, String> contactInfo = {};

        for (var item in data) {
          contactInfo[item['key']] = item['value'];
        }

        return contactInfo;
      } else {
        throw Exception('Failed to load contact info');
      }
    } catch (e) {
      // Fallback data if API fails
      return {
        'email': 'support@healthcare.com',
        'phone': '+91 98765 43200',
        'working_hours': 'Mon-Fri, 9AM-6PM',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: fetchContactInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final contactInfo = snapshot.data ?? {};

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(Icons.support_agent, size: 80, color: Colors.deepPurple),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Application Support",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "For any technical issues or questions about the app functionality.",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // Contact Information
              const Text(
                "Contact Us:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildContactRow(Icons.email, contactInfo['email'] ?? 'Not available'),
              const SizedBox(height: 10),
              _buildContactRow(Icons.phone, contactInfo['phone'] ?? 'Not available'),
              const SizedBox(height: 10),
              _buildContactRow(Icons.access_time, contactInfo['working_hours'] ?? 'Not available'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.deepPurple),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }
}

class DoctorSupportTab extends StatelessWidget {
  const DoctorSupportTab({super.key});

  // Method to fetch doctor info from the database
  Future<List<Map<String, dynamic>>> fetchDoctorInfo() async {
    try {
      final response = await http.get(
        Uri.parse('YOUR_API_ENDPOINT/doctor_support'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load doctor info');
      }
    } catch (e) {
      // Fallback data if API fails
      return [
        {
          'name': 'Dr. Ramesh Kumar',
          'designation': 'Cardiologist',
          'email': 'dr.ramesh@healthcare.com',
          'mobile': '+91 98765 43210'
        },
        {
          'name': 'Dr. Priya Sharma',
          'designation': 'Pediatrician',
          'email': 'dr.priya@healthcare.com',
          'mobile': '+91 98765 43211'
        },
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchDoctorInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final doctors = snapshot.data ?? [];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Icon(Icons.medical_services, size: 80, color: Colors.deepPurple),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "Doctor Support",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  "Contact our medical team for health-related queries",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // Doctor List
              const Text(
                "Available Doctors:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              if (doctors.isEmpty)
                const Center(child: Text('No doctors available')),

              ...doctors.map((doctor) => _buildDoctorCard(
                doctor['name'],
                doctor['designation'],
                doctor['email'],
                doctor['mobile'],
              )).toList(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDoctorCard(String name, String designation, String email, String mobile) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              designation,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 10),
            _buildContactRow(Icons.email, email),
            const SizedBox(height: 8),
            _buildContactRow(Icons.phone, mobile),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.deepPurple),
        const SizedBox(width: 10),
        Text(text),
      ],
    );
  }
}