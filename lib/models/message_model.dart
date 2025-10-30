import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  text,
  image,
  gif,
}

class MessageModel {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final MessageType type;
  final Timestamp timestamp;
  final bool isRead;

  MessageModel({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    this.type = MessageType.text,
    required this.timestamp,
    this.isRead = false,
  });

  factory MessageModel.fromMap(Map<String, dynamic> data) {
    return MessageModel(
      senderId: data['senderId'] ?? '',
      senderEmail: data['senderEmail'] ?? '',
      receiverId: data['receiverId'] ?? '',
      message: data['message'] ?? '',
      type: MessageType.values.firstWhere(
        (e) => e.toString() == 'MessageType.${data['type']}', // String interpolation kullanıldı
        orElse: () => MessageType.text,
      ),
      timestamp: data['timestamp'] ?? Timestamp.now(),
      isRead: data['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'type': type.toString().split('.').last,
      'timestamp': timestamp,
      'isRead': isRead,
    };
  }
}
