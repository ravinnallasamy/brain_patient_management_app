import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.support_agent, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 20),
            const Text(
              "Need Help?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "For any queries or technical assistance, contact us via email or phone.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Icon(Icons.email, color: Colors.deepPurple),
                SizedBox(width: 10),
                Text("support@healthcare.com"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(Icons.phone, color: Colors.deepPurple),
                SizedBox(width: 10),
                Text("+91 98765 43210"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
