import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// 👇 Replace this with the actual path to your LoginScreen
import 'login_screen.dart'; // Example: 'package:your_app/screens/login_screen.dart'

class LogoutPage extends StatelessWidget {
  final String patientId;

  const LogoutPage({super.key, required this.patientId});

  Future<void> _updateLogoutTime(BuildContext context) async {
    try {
      final supabase = Supabase.instance.client;

      // Update logout time in database
      final response = await supabase
          .from('users')
          .update({
        'last_logout_time': DateTime.now().toUtc().toIso8601String(),
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      })
          .eq('patient_id', patientId);

      // If error, throw exception
      if (response == null) {
        throw Exception("Null response from Supabase");
      }

      if (!context.mounted) return;

      // Navigate to LoginScreen and clear history
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
      );
    } on PostgrestException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout time update failed: ${e.message}')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error during logout: $e')),
        );

        // Navigate anyway even if error occurred
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Logout'),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
          ),
          onPressed: () => _updateLogoutTime(context),
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
