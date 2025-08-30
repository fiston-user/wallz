import 'package:flutter/material.dart';
import '../models/wallpaper.dart';
import '../services/wallpaper_service.dart';

class WallpaperProvider extends ChangeNotifier {
  final WallpaperService _service = WallpaperService();
  
  List<Wallpaper> _wallpapers = [];
  List<Wallpaper> _searchResults = [];
  List<Wallpaper> _categoryWallpapers = [];
  final Set<String> _favorites = {};
  
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  String? _currentQuery;
  String? _currentCategory;
  String? _error;

  List<Wallpaper> get wallpapers => _wallpapers;
  List<Wallpaper> get searchResults => _searchResults;
  List<Wallpaper> get categoryWallpapers => _categoryWallpapers;
  Set<String> get favorites => _favorites;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;

  Future<void> loadWallpapers({bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh) {
      _currentPage = 1;
      _wallpapers = [];
      _hasMore = true;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newWallpapers = await _service.getWallpapers(
        page: _currentPage,
      );

      if (newWallpapers.isEmpty) {
        _hasMore = false;
      } else {
        _wallpapers.addAll(newWallpapers);
        _currentPage++;
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> searchWallpapers(String query, {bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh || query != _currentQuery) {
      _currentPage = 1;
      _searchResults = [];
      _hasMore = true;
      _currentQuery = query;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newWallpapers = await _service.getWallpapers(
        page: _currentPage,
        query: query,
      );

      if (newWallpapers.isEmpty) {
        _hasMore = false;
      } else {
        _searchResults.addAll(newWallpapers);
        _currentPage++;
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadCategoryWallpapers(String category, {bool refresh = false}) async {
    if (_isLoading) return;

    if (refresh || category != _currentCategory) {
      _currentPage = 1;
      _categoryWallpapers = [];
      _hasMore = true;
      _currentCategory = category;
    }

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newWallpapers = await _service.getWallpapers(
        page: _currentPage,
        category: category,
      );

      if (newWallpapers.isEmpty) {
        _hasMore = false;
      } else {
        _categoryWallpapers.addAll(newWallpapers);
        _currentPage++;
      }
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void toggleFavorite(String wallpaperId) {
    if (_favorites.contains(wallpaperId)) {
      _favorites.remove(wallpaperId);
    } else {
      _favorites.add(wallpaperId);
    }
    notifyListeners();
    // TODO: Save favorites to SharedPreferences
  }

  bool isFavorite(String wallpaperId) {
    return _favorites.contains(wallpaperId);
  }

  void clearSearch() {
    _searchResults = [];
    _currentQuery = null;
    _currentPage = 1;
    notifyListeners();
  }

  void clearCategory() {
    _categoryWallpapers = [];
    _currentCategory = null;
    _currentPage = 1;
    notifyListeners();
  }
}