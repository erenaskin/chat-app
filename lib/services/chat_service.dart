import 'dart:io';
import 'package:chat_app/models/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/foundation.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Tüm kullanıcıları stream olarak al
  Stream<List<UserModel>> getUsersStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
    });
  }

  // Sohbet odalarını stream olarak al
  Stream<List<ChatRoomModel>> getChatRoomsStream(String userId) {
    return _firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastMessageTime', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => ChatRoomModel.fromMap(doc.data())).toList();
    });
  }

  // Tek bir sohbet odasının mesajlarını al
  Stream<List<MessageModel>> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => MessageModel.fromMap(doc.data())).toList();
    });
  }

  // Mesaj gönderme
  Future<void> sendMessage(String receiverId, String message, {MessageType type = MessageType.text}) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    MessageModel newMessage = MessageModel(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverId,
      message: message,
      type: type,
      timestamp: timestamp,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    // Sohbet odası koleksiyonunu kontrol et ve oluştur/güncelle
    await _firestore.collection('chats').doc(chatRoomId).set({
      'participants': ids,
      'lastMessage': type == MessageType.text ? message : '[Medya Mesajı]',
      'lastMessageTime': timestamp,
      'lastMessageSenderId': currentUserId,
      // 'unreadCount' gibi diğer alanlar burada güncellenebilir
    }, SetOptions(merge: true));

    // Mesajı alt koleksiyona ekle
    await _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  // Medya (resim) gönderme
  Future<String?> uploadFile(File file, String path) async {
    try {
      final ref = _storage.ref().child(path);
      final uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Dosya yükleme hatası: $e');
      return null;
    }
  }

  Future<void> sendMediaMessage(String receiverId, File imageFile, MessageType type) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String path = 'chat_media/${currentUserId}_${receiverId}_${DateTime.now().millisecondsSinceEpoch}';
    final String? imageUrl = await uploadFile(imageFile, path);

    if (imageUrl != null) {
      await sendMessage(receiverId, imageUrl, type: type);
    } else {
      debugPrint('Medya mesajı gönderilemedi: Resim yüklenemedi.');
    }
  }

  // Okundu bilgisini güncelleme (bonus özellik)
  Future<void> markMessageAsRead(String chatRoomId, String messageId) async { // currentUserId parametresi kaldırıldı
    await _firestore
        .collection('chats')
        .doc(chatRoomId)
        .collection('messages')
        .doc(messageId)
        .update({'isRead': true});
  }

  // Kullanıcının çevrimiçi durumunu ve son görülme zamanını günceller
  Future<void> setUserStatus(String uid, bool isOnline) async {
    await _firestore.collection('users').doc(uid).update({
      'isOnline': isOnline,
      'lastSeen': Timestamp.now(),
    });
  }
}
