import 'dart:io';

import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:chat_app/widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  final UserModel receiverUser;

  const ChatScreen({super.key, required this.receiverUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  User? get _currentUser => FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverUser.uid,
        _messageController.text,
      );
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _sendMediaMessage(ImageSource source, MessageType type) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await _chatService.sendMediaMessage(
        widget.receiverUser.uid,
        imageFile,
        type,
      );
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.receiverUser.photoUrl != null
                  ? NetworkImage(widget.receiverUser.photoUrl!) as ImageProvider
                  : const AssetImage('assets/default_avatar.png'),
              child: widget.receiverUser.photoUrl == null
                  ? Text(widget.receiverUser.displayName[0].toUpperCase())
                  : null,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.receiverUser.displayName),
                StreamBuilder<List<UserModel>>(
                  stream: _chatService.getUsersStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final updatedUser = snapshot.data!.firstWhere(
                          (user) => user.uid == widget.receiverUser.uid,
                          orElse: () => widget.receiverUser);
                      return Text(
                        updatedUser.isOnline
                            ? 'Çevrimiçi'
                            : 'Son görülme: ${DateFormat('HH:mm').format(updatedUser.lastSeen.toDate())}',
                        style: Theme.of(context).textTheme.bodySmall,
                      );
                    }
                    return Text(
                      widget.receiverUser.isOnline
                          ? 'Çevrimiçi'
                          : 'Son görülme: ${DateFormat('HH:mm').format(widget.receiverUser.lastSeen.toDate())}',
                      style: Theme.of(context).textTheme.bodySmall,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder<List<MessageModel>>(
      stream: _chatService.getMessages(
        _currentUser!.uid,
        widget.receiverUser.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = snapshot.data!; 

        return ListView.builder(
          controller: _scrollController,
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isCurrentUser = message.senderId == _currentUser!.uid;
            return MessageBubble(message: message, isCurrentUser: isCurrentUser);
          },
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 8.0,
        left: 8.0,
        right: 8.0,
        top: 8.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Mesaj yaz...',
                // Mevcut tema ayarlarını kullanmak için burada sadece override ediyoruz.
                // Diğer border, filled, fillColor gibi ayarlar inputDecorationTheme'den gelecektir.
                suffixIconConstraints: BoxConstraints(
                  minWidth: 80,
                  maxHeight: 48,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.photo_outlined),
                      onPressed: () => _sendMediaMessage(ImageSource.gallery, MessageType.image),
                      tooltip: 'Resim gönder',
                    ),
                    IconButton(
                      icon: const Icon(Icons.gif_outlined),
                      onPressed: () => _sendMediaMessage(ImageSource.gallery, MessageType.gif),
                      tooltip: 'GIF gönder',
                    ),
                  ],
                ),
              ),
              obscureText: false,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
              tooltip: 'Mesaj gönder',
            ),
          ),
        ],
      ),
    );
  }
}
