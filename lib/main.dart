import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/Dashboard/dashboard.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://clucqqrsdbchiufdflsf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNsdWNxcXJzZGJjaGl1ZmRmbHNmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY5MDQ1NjksImV4cCI6MjA2MjQ4MDU2OX0.3d5CYYbyJWGNfXoozNgN96BHi0R8u8LKyOr6HDmeY-E',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

=======
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/Dashboard/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
>>>>>>> ac42521
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brain Tumor Patient App',
<<<<<<< HEAD
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
=======
      debugShowCheckedModeBanner: false, // Add this line to remove red DEBUG banner
>>>>>>> ac42521
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
<<<<<<< HEAD
        '/dashboard': (context) {
          final args = ModalRoute.of(context)!.settings.arguments
          as Map<String, dynamic>? ?? {};
          return DashboardScreen(userData: args); // This should match your dashboard class name
        },
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
      },
      onGenerateRoute: (settings) {
        // You can add more route generation logic here if needed
        return null;
      },
    );
  }
}
=======
        '/home': (context) => const DashboardScreen(),
      },
    );
  }
}
>>>>>>> ac42521
