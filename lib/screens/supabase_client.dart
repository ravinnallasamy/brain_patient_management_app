import 'package:supabase_flutter/supabase_flutter.dart';

class AppSupabaseClient {
  final SupabaseClient client;

  AppSupabaseClient() : client = Supabase.instance.client;

  // For login - simplified version without registration
  Future<Map<String, dynamic>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // Find user by email
      final userResponse = await client
          .from('users')
          .select()
          .eq('email', email)
          .maybeSingle();

      if (userResponse == null) {
        throw Exception('Invalid email or password');
      }

      // Verify password (plain text comparison)
      if (userResponse['password'] != password) {
        throw Exception('Invalid email or password');
      }

      // Get patient data
      final patientId = int.parse(userResponse['patient_id'].toString());
      final patientData = await getPatientById(patientId);

      if (patientData == null) {
        throw Exception('Patient record not found');
      }

      return {
        'user': userResponse,
        'patient': patientData,
      };
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>?> getPatientById(int patientId) async {
    try {
      final response = await client
          .from('patients')
          .select()
          .eq('id', patientId.toString())
          .maybeSingle();
      return response;
    } catch (e) {
      throw Exception('Failed to fetch patient: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    // Clear any client-side cache if needed
  }
}