import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomModel {
  final String chatRoomId;
  final List<String> participants;
  final String lastMessage;
  final Timestamp lastMessageTime;
  final String lastMessageSenderId;
  final int unreadCount;

  ChatRoomModel({
    required this.chatRoomId,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.lastMessageSenderId,
    this.unreadCount = 0,
  });

  factory ChatRoomModel.fromMap(Map<String, dynamic> data) {
    return ChatRoomModel(
      chatRoomId: data['chatRoomId'] ?? '',
      participants: List<String>.from(data['participants'] ?? []),
      lastMessage: data['lastMessage'] ?? '',
      lastMessageTime: data['lastMessageTime'] ?? Timestamp.now(),
      lastMessageSenderId: data['lastMessageSenderId'] ?? '',
      unreadCount: data['unreadCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'chatRoomId': chatRoomId,
      'participants': participants,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastMessageSenderId': lastMessageSenderId,
      'unreadCount': unreadCount,
    };
  }
}
