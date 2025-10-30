import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:flutter/foundation.dart'; // Import for debugPrint

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Returns the currently signed-in user.
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Kullanıcı oturum değişikliklerini dinler
  Stream<User?> get user => _auth.authStateChanges();

  // Kullanıcı bilgilerini Firestore'a kaydetme/güncelleme
  Future<void> _saveUserToFirestore(User user) async {
    final userDoc = _firestore.collection('users').doc(user.uid);
    final userSnapshot = await userDoc.get();

    if (!userSnapshot.exists) {
      // Yeni kullanıcı
      await userDoc.set(UserModel(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName ?? user.email!.split('@')[0],
        photoUrl: user.photoURL,
        status: 'Hey there! I am using ChatApp.',
        isOnline: true,
        lastSeen: Timestamp.now(),
      ).toMap());
    } else {
      // Mevcut kullanıcı, çevrimiçi durumunu güncelle
      await userDoc.update({
        'isOnline': true,
        'lastSeen': Timestamp.now(),
      });
    }
  }

  // Email/Şifre ile kayıt
  Future<User?> signUpWithEmail(String email, String password, String displayName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await user.updateDisplayName(displayName);
        await _saveUserToFirestore(user);
      }
      return user;
    } catch (e) {
      debugPrint('Email kayıt hatası: $e');
      return null;
    }
  }

  // Email/Şifre ile giriş
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        await _saveUserToFirestore(user);
      }
      return user;
    } catch (e) {
      debugPrint('Email giriş hatası: $e');
      return null;
    }
  }

  // Çıkış yap
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // Çıkış yapıldığı için _auth.currentUser null olabilir, bu yüzden kontrol ekledik.
      if (_auth.currentUser != null) {
        await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
          'isOnline': false,
          'lastSeen': Timestamp.now(),
        });
      }
    } catch (e) {
      debugPrint('Çıkış hatası: $e');
    }
  }

  // Kullanıcının şifresini değiştir
  Future<String?> updatePassword(String newPassword) async {
    try {
      await _auth.currentUser?.updatePassword(newPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      debugPrint('Şifre güncelleme hatası: ${e.code}');
      return e.message; // Hata mesajını döndür
    } catch (e) {
      debugPrint('Şifre güncelleme hatası: $e');
      return 'Bilinmeyen bir hata oluştu.';
    }
  }

  // Kullanıcının çevrimiçi durumunu güncelle
  Future<void> updateUserOnlineStatus(String uid, bool isOnline) async {
    await _firestore.collection('users').doc(uid).update({
      'isOnline': isOnline,
      'lastSeen': Timestamp.now(),
    });
  }
}
