import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String displayName;
  final String? photoUrl;
  final String? status;
  final bool isOnline;
  final Timestamp lastSeen;

  UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.status,
    this.isOnline = false,
    required this.lastSeen,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      photoUrl: data['photoUrl'],
      status: data['status'],
      isOnline: data['isOnline'] ?? false,
      lastSeen: data['lastSeen'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'status': status,
      'isOnline': isOnline,
      'lastSeen': lastSeen,
    };
  }
}
