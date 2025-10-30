import 'dart:io';

import 'package:chat_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  UserModel? _currentUserModel;
  bool _isLoading = true;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _currentUserModel = UserModel.fromMap(userDoc.data()!);
          _displayNameController.text = _currentUserModel!.displayName;
          _statusController.text = _currentUserModel!.status ?? '';
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadProfileImage() async {
    if (_pickedImage == null) return null;

    try {
      final user = _auth.currentUser!;
      final ref = _storage.ref().child('profile_pictures').child('${user.uid}.jpg');
      await ref.putFile(_pickedImage!);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint('Profil resmi yükleme hatası: $e'); // debugPrint kullanıldı
      return null;
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    String? newPhotoUrl = _currentUserModel?.photoUrl;
    if (_pickedImage != null) {
      newPhotoUrl = await _uploadProfileImage();
    }

    final user = _auth.currentUser!;
    await _firestore.collection('users').doc(user.uid).update({
      'displayName': _displayNameController.text,
      'status': _statusController.text,
      'photoUrl': newPhotoUrl,
    });

    await user.updateDisplayName(_displayNameController.text);
    if (newPhotoUrl != null) {
      await user.updatePhotoURL(newPhotoUrl);
    }

    setState(() {
      _isLoading = false;
    });
    _loadUserProfile(); // Profil bilgilerini yeniden yükle
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil başarıyla güncellendi!')),
    );
  }

  // Şifre değiştirme dialogu (Artık LoginScreen'den gidilecek bir PasswordResetScreen var)
  // Bu metodu kaldırıyoruz veya başka bir yere taşıyoruz.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilim'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      backgroundImage: _pickedImage != null
                          ? FileImage(_pickedImage!) as ImageProvider
                          : (_currentUserModel?.photoUrl != null
                              ? NetworkImage(_currentUserModel!.photoUrl!)
                              : const AssetImage('assets/default_avatar.png')) as ImageProvider,
                      child: (_pickedImage == null && _currentUserModel?.photoUrl == null)
                          ? Text(
                              _currentUserModel?.displayName[0].toUpperCase() ?? '',
                              style: const TextStyle(fontSize: 48, color: Colors.white),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _displayNameController,
                    decoration: const InputDecoration(
                      labelText: 'Görünen İsim',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _statusController,
                    decoration: const InputDecoration(
                      labelText: 'Durum',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.info_outline),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Profili Güncelle',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  // Şifre değiştirme butonu kaldırıldı
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _statusController.dispose();
    _newPasswordController.dispose(); 
    super.dispose();
  }
}
