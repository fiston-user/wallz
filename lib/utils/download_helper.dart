import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadHelper {
  static Future<bool> downloadImage(String imageUrl, String fileName) async {
    try {
      // Check and request storage permission
      if (Platform.isAndroid) {
        // For Android 10+ (API 29+), we don't need WRITE_EXTERNAL_STORAGE
        if (await _isAndroid10OrAbove()) {
          // No permission needed for app-specific directory
        } else {
          final status = await Permission.storage.status;
          if (!status.isGranted) {
            final result = await Permission.storage.request();
            if (!result.isGranted) {
              throw Exception('Storage permission denied');
            }
          }
        }
      }

      // Download the image
      final file = await DefaultCacheManager().getSingleFile(imageUrl);
      
      if (!await file.exists()) {
        throw Exception('Failed to download image');
      }

      // Get the directory to save the image
      Directory? directory;
      if (Platform.isAndroid) {
        // For Android, save to Pictures directory
        directory = Directory('/storage/emulated/0/Pictures/Wallz');
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
      } else if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      // Copy the file to the downloads directory
      final String filePath = '${directory.path}/$fileName';
      final File newFile = await file.copy(filePath);

      return await newFile.exists();
    } catch (e) {
      // Error handled silently
      return false;
    }
  }

  static Future<bool> _isAndroid10OrAbove() async {
    if (Platform.isAndroid) {
      // Android 10 is API level 29
      return true; // Simplified for now, in production you'd check actual API level
    }
    return false;
  }

  static Future<String?> getDownloadPath() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Pictures/Wallz');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
    } else if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = await getDownloadsDirectory();
    }
    
    return directory?.path;
  }
}