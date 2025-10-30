import 'package:chat_app/models/user_model.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  final VoidCallback onTap;

  const UserTile({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: user.photoUrl != null
            ? NetworkImage(user.photoUrl!) as ImageProvider
            : const AssetImage('assets/default_avatar.png'), // Varsayılan avatar ekleyin
        child: user.photoUrl == null ? Text(user.displayName[0].toUpperCase()) : null,
      ),
      title: Text(user.displayName),
      subtitle: Text(user.isOnline ? 'Çevrimiçi' : 'Son görülme: ${user.lastSeen.toDate().toLocal().toString().split('.')[0]}'),
      trailing: user.isOnline ? const Icon(Icons.circle, color: Colors.green, size: 12) : null,
      onTap: onTap,
    );
  }
}
