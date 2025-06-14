import 'package:flutter/material.dart';
import 'daily_health_entry_page.dart';
import 'upcoming_consultation_page.dart';
import 'reports_page.dart';
import 'progress_summary_page.dart';
import 'support_page.dart';
<<<<<<< HEAD
import 'logout_page.dart';
import 'package:flutter/foundation.dart';

class DashboardScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const DashboardScreen({
    super.key,
    required this.userData,
  });
=======
import 'logout_page.dart'; // This is the AlertDialog file

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
>>>>>>> ac42521

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _scaleFactor = 1.0;
<<<<<<< HEAD
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onTileTap() {
    setState(() => _scaleFactor = 1.1);
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _scaleFactor = 1.0);
=======

  // Drawer state
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onTileTap() {
    setState(() {
      _scaleFactor = 1.1;
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _scaleFactor = 1.0;
      });
>>>>>>> ac42521
    });
  }

  void _handleNavigation(String title) {
    _onTileTap();
<<<<<<< HEAD
    switch (title) {
      case "Daily Health Entry":
        final patientId = widget.userData['user']?['patient_id']?.toString() ?? '';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DailyHealthEntryPage(patientId: patientId),
          ),
        );
        break;

      case "Upcoming Consultation":
        final patientId = widget.userData['user']?['patient_id'];
        if (patientId != null && patientId is int) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UpcomingConsultationPage(patientId: patientId),
            ),
          );
        } else {
          debugPrint('Invalid patient ID: $patientId');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid patient ID.')),
          );
        }
        break;
      case "Reports":
        final patientId = widget.userData['user']?['patient_id'];
        if (patientId != null && patientId is int) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ReportsPage(patientId: patientId),
            ),
          );
        } else {
          debugPrint('Invalid patient ID: $patientId');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid patient ID.')),
          );
        }
        break;
      case "Progress Summary":
        final patientId = widget.userData['user']?['patient_id'];
        if (patientId != null && patientId is int) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProgressSummaryPage(patientId: patientId),
            ),
          );
        } else {
          debugPrint('Invalid patient ID: $patientId');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid patient ID.')),
          );
        }
        break;

      case "Support":
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportPage()));
        break;
      case "Logout":
        final patientId = widget.userData['user']?['patient_id'];
        if (patientId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LogoutPage(patientId: patientId.toString()),
            ),
          );
        } else {
          debugPrint('Invalid patient ID: $patientId');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid patient ID.')),
          );
        }
        break;
    }
  }

  void _showPersonalInfo() => _scaffoldKey.currentState?.openDrawer();

  Widget _buildDrawerContent() {
    final user = widget.userData['user'] ?? {};
    final patient = widget.userData['patient'] ?? {};

    return Drawer(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
=======
    if (title == "Daily Health Entry") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const DailyHealthEntryPage()));
    } else if (title == "Upcoming Consultation") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const UpcomingConsultationPage()));
    } else if (title == "Reports") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsPage()));
    } else if (title == "Progress Summary") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProgressSummaryPage()));
    } else if (title == "Support") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const SupportPage()));
    } else if (title == "Logout") {
      showDialog(
        context: context,
        builder: (context) => const LogoutPage(),
      );
    }
  }

  // Show personal information drawer
  void _showPersonalInfo() {
    _scaffoldKey.currentState?.openDrawer();
  }

  // Build the drawer content for personal information
  Widget _buildDrawerContent() {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
>>>>>>> ac42521
        child: Column(
          children: [
            const Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            Container(
<<<<<<< HEAD
              padding: const EdgeInsets.all(12),
=======
              padding: const EdgeInsets.all(12.0),
>>>>>>> ac42521
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple, width: 2),
                color: Colors.deepPurple.shade50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
<<<<<<< HEAD
                  _buildInfoTile('User ID:', user['id']?.toString() ?? 'Unknown'),
                  _buildInfoTile('Name:', user['name']?.toString() ?? 'Unknown'),
                  _buildInfoTile('Patient ID:', user['patient_id']?.toString() ?? ''),
                  _buildInfoTile('Email:', user['email']?.toString() ?? ''),
                  if (patient.isNotEmpty) ...[
                    _buildInfoTile('Age:', patient['age']?.toString() ?? ''),
                    _buildInfoTile('Gender:', patient['gender']?.toString() ?? ''),
                    _buildInfoTile('DOB:', patient['dob']?.toString() ?? ''),
                    _buildInfoTile('Blood Group:', patient['blood_group']?.toString() ?? ''),
                    _buildInfoTile('Surgery Date:', patient['surgery_date']?.toString() ?? ''),
                  ],
                ],
              ),
            ),
            // Only show debug information in debug mode
            if (kDebugMode) ...[
              const SizedBox(height: 20),
              const Text(
                'Debug Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Full user data: ${widget.userData.toString()}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
=======
                  _buildInfoTile('Name:', 'John Doe'),
                  _buildInfoTile('Age:', '30'),
                  _buildInfoTile('Gender:', 'Female'),
                  _buildInfoTile('DOB:', '01/01/1995'),
                  _buildInfoTile('Blood Group:', 'O+'),
                  _buildInfoTile('Surgery Date:', '12/12/2023'),
                  _buildInfoTile('Phone:', '+1234567890'),
                  _buildInfoTile('Email ID:', 'johndoe@example.com'),
                ],
              ),
            ),
>>>>>>> ac42521
          ],
        ),
      ),
    );
  }

<<<<<<< HEAD
  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
=======
  // Build each info tile for displaying personal information
  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
>>>>>>> ac42521
      child: Row(
        children: [
          Text(
            '$label ',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          Expanded(
            child: Text(
              value,
<<<<<<< HEAD
              style: const TextStyle(fontSize: 18),
=======
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
>>>>>>> ac42521
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    final user = widget.userData['user'] as Map<String, dynamic>? ?? {};
    final userName = user['name']?.toString() ?? 'User'; // Fixed: Define userName here

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Welcome, $userName"), // Now using the properly defined userName
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.account_circle, size: 28),
          onPressed: _showPersonalInfo,
=======
    return Scaffold(
      key: _scaffoldKey, // Assign the scaffold key here
      appBar: AppBar(
        title: const Text("Patient Dashboard"),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: _showPersonalInfo, // Show personal info drawer
>>>>>>> ac42521
        ),
      ),
      body: Column(
        children: [
<<<<<<< HEAD
          SizedBox(
            height: 150,
            width: double.infinity,
=======
          // 👉 Top banner image
          SizedBox(
            width: double.infinity,
            height: 150,
>>>>>>> ac42521
            child: Image.asset(
              'lib/images/dboard.jpeg',
              fit: BoxFit.cover,
            ),
          ),
<<<<<<< HEAD
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildTile("Daily Health Entry", Icons.edit),
                _buildTile("Upcoming Consultation", Icons.calendar_today),
                _buildTile("Reports", Icons.upload_file),
                _buildTile("Progress Summary", Icons.insights),
                _buildTile("Support", Icons.help_outline),
                _buildTile("Logout", Icons.logout),
=======

          // 👉 Dashboard Grid Tiles
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16.0),
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: [
                _buildTile(context, "Daily Health Entry", Icons.edit),
                _buildTile(context, "Upcoming Consultation", Icons.calendar_today),
                _buildTile(context, "Reports", Icons.upload_file),
                _buildTile(context, "Progress Summary", Icons.insights),
                _buildTile(context, "Support", Icons.help_outline),
                _buildTile(context, "Logout", Icons.logout),
>>>>>>> ac42521
              ],
            ),
          ),
        ],
      ),
<<<<<<< HEAD
=======
      // 👉 Add the Drawer to the Scaffold
>>>>>>> ac42521
      drawer: _buildDrawerContent(),
    );
  }

<<<<<<< HEAD
  Widget _buildTile(String title, IconData icon) {
=======
  Widget _buildTile(BuildContext context, String title, IconData icon) {
>>>>>>> ac42521
    return GestureDetector(
      onTap: () => _handleNavigation(title),
      child: AnimatedScale(
        scale: _scaleFactor,
        duration: const Duration(milliseconds: 150),
        child: Container(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.deepPurple),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
}
=======
}
>>>>>>> ac42521
