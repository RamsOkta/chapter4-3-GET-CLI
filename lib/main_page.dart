import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatelessWidget {
  Future<void> _selectAndSaveImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final image = File(pickedFile.path);

      GetStorage().write('profile_image_path', image.path);
      // Memperbarui tampilan ketika gambar profil berubah
      Get.forceAppUpdate();
    } else {
      print('User membatalkan pemilihan gambar');
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = GetStorage().read('nama') ?? '';
    String job = GetStorage().read('pekerjaan') ?? '';
    String profileImagePath = GetStorage().read('profile_image_path') ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              // Menggunakan gambar profil jika sudah ada
              backgroundImage: profileImagePath.isNotEmpty
                  ? FileImage(File(profileImagePath))
                  : null,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : '',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nama: $name',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pekerjaan: $job',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectAndSaveImage,
              child: Text('Edit Foto Profil'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAllNamed('/login');
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
