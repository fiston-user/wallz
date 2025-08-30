import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/wallpaper.dart';
import '../utils/api_config.dart';

class WallpaperService {
  static final WallpaperService _instance = WallpaperService._internal();
  factory WallpaperService() => _instance;
  WallpaperService._internal();

  Future<List<Wallpaper>> getWallpapers({
    int page = 1,
    String? query,
    String? category,
  }) async {
    try {
      String endpoint;
      Map<String, String> queryParams = {
        'page': page.toString(),
        'per_page': ApiConfig.perPage.toString(),
      };

      if (query != null && query.isNotEmpty) {
        endpoint = '/search/photos';
        queryParams['query'] = query;
      } else if (category != null && category.isNotEmpty) {
        endpoint = '/search/photos';
        queryParams['query'] = category;
        queryParams['orientation'] = 'portrait';
      } else {
        endpoint = '/photos';
        queryParams['order_by'] = 'popular';
      }

      final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint')
          .replace(queryParameters: queryParams);

      final response = await http.get(
        uri,
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<dynamic> results;
        
        if (query != null || category != null) {
          results = data['results'] ?? [];
        } else {
          results = data ?? [];
        }

        return results.map((json) => Wallpaper.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load wallpapers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching wallpapers: $e');
    }
  }

  Future<Wallpaper> getWallpaperDetails(String id) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/photos/$id');
      
      final response = await http.get(
        uri,
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Wallpaper.fromJson(data);
      } else {
        throw Exception('Failed to load wallpaper details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching wallpaper details: $e');
    }
  }

  Future<List<Wallpaper>> getRandomWallpapers({int count = 10}) async {
    try {
      final uri = Uri.parse('${ApiConfig.baseUrl}/photos/random')
          .replace(queryParameters: {
        'count': count.toString(),
        'orientation': 'portrait',
      });

      final response = await http.get(
        uri,
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data ?? [];
        return results.map((json) => Wallpaper.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load random wallpapers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching random wallpapers: $e');
    }
  }
}