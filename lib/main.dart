import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/features/auth/screens/login_screen.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/theme.dart'; // Tema dosyasını import ediyoruz
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        // Diğer servisler buraya eklenecek
      ],
      child: MaterialApp(
        title: 'Flutter Chat App',
        theme: AppTheme.lightTheme, // Aydınlık temayı kullan
        darkTheme: AppTheme.darkTheme, // Karanlık temayı kullan
        themeMode: ThemeMode.system, // Sistem temasına göre otomatik dark/light mode
        home: LoginScreen(),
      ),
    );
  }
}
