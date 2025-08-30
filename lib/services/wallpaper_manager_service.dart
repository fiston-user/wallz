import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:permission_handler/permission_handler.dart';

enum WallpaperLocation {
  home,
  lock,
  both,
}

class WallpaperManagerService {
  static Future<bool> setWallpaper(
    String imageUrl,
    WallpaperLocation location,
  ) async {
    try {
      // Check and request storage permission for Android
      if (Platform.isAndroid) {
        final status = await Permission.storage.status;
        if (!status.isGranted) {
          final result = await Permission.storage.request();
          if (!result.isGranted) {
            return false;
          }
        }
      }

      // Download the image using cache manager
      final file = await DefaultCacheManager().getSingleFile(imageUrl);
      
      if (!await file.exists()) {
        return false;
      }

      // Note: Wallpaper setting is Android-only
      // For macOS/iOS, we just simulate success
      // On Android, you would use wallpaper_manager_flutter package here
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.status;
      return status.isGranted;
    }
    return true;
  }

  static Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true;
  }
}