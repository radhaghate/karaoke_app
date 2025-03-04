import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ltecgnkwpvvsbqjsilee.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx0ZWNnbmt3cHZ2c2JxanNpbGVlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDExMTY4MTQsImV4cCI6MjA1NjY5MjgxNH0.UdSmEu7D0mayj87MTTY-vzccP0K9w0TmNKYoLUYooSo',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karaoke App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(), // Now uses the default Rick Roll video
    );
  }
}