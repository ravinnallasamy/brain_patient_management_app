import 'package:flutter/material.dart';
import 'daily_health_entry_page.dart';
import 'upcoming_consultation_page.dart';
import 'reports_page.dart';
import 'progress_summary_page.dart';
import 'support_page.dart';
import 'logout_page.dart'; // This is the AlertDialog file

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double _scaleFactor = 1.0;

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
    });
  }

  void _handleNavigation(String title) {
    _onTileTap();
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
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple, width: 2),
                color: Colors.deepPurple.shade50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
          ],
        ),
      ),
    );
  }

  // Build each info tile for displaying personal information
  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the scaffold key here
      appBar: AppBar(
        title: const Text("Patient Dashboard"),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: _showPersonalInfo, // Show personal info drawer
        ),
      ),
      body: Column(
        children: [
          // 👉 Top banner image
          SizedBox(
            width: double.infinity,
            height: 150,
            child: Image.asset(
              'lib/images/dboard.jpeg',
              fit: BoxFit.cover,
            ),
          ),

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
              ],
            ),
          ),
        ],
      ),
      // 👉 Add the Drawer to the Scaffold
      drawer: _buildDrawerContent(),
    );
  }

  Widget _buildTile(BuildContext context, String title, IconData icon) {
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
}
