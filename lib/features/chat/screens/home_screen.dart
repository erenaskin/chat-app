import 'package:chat_app/features/auth/screens/login_screen.dart';
import 'package:chat_app/features/chat/screens/chat_screen.dart';
import 'package:chat_app/features/profile/screens/profile_screen.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_app/widgets/user_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final ChatService _chatService = ChatService();
  // AuthService bir provider üzerinden geldiği için burada final olarak tanımlanmamalı
  // final AuthService _authService = AuthService(); // Bu satırı kaldırıyoruz

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // _authService artık doğrudan erişilemez, Provider.of kullanmalıyız
    // Ancak initState içinde context henüz tamamen hazır olmayabilir.
    // Bu yüzden setUserOnlineStatus çağrısını didChangeDependencies veya postFrameCallback içinde yapabiliriz.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setUserOnlineStatus(true);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _setUserOnlineStatus(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final authService = Provider.of<AuthService>(context, listen: false);
    if (authService.getCurrentUser() == null) return; // Kullanıcı yoksa işlem yapma

    if (state == AppLifecycleState.resumed) {
      _setUserOnlineStatus(true);
    } else {
      _setUserOnlineStatus(false);
    }
  }

  Future<void> _setUserOnlineStatus(bool isOnline) async {
    // Context hazır olduğu için provider ile AuthService'e erişebiliriz.
    final authService = Provider.of<AuthService>(context, listen: false);
    final currentUser = authService.getCurrentUser();
    if (currentUser != null) {
      await _chatService.setUserStatus(currentUser.uid, isOnline);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kullanıcılar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authService.signOut();
              // Navigator.of(context).pushReplacement kullanmadan önce widget'ın mount edilmiş olup olmadığını kontrol edin.
              if (!mounted) return; 
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Hiç kullanıcı bulunamadı.'));
          }

          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              // Kendi kendimize mesaj göndermeyi engelle
              if (user.uid == FirebaseAuth.instance.currentUser!.uid) {
                return const SizedBox.shrink();
              }
              return UserTile(
                user: user,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(receiverUser: user),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
