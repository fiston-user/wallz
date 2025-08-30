import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';
import '../models/wallpaper.dart';
import 'wallpaper_tile.dart';

class WallpaperGrid extends StatefulWidget {
  final List<Wallpaper> wallpapers;
  final bool isLoading;
  final VoidCallback? onLoadMore;

  const WallpaperGrid({
    super.key,
    required this.wallpapers,
    required this.isLoading,
    this.onLoadMore,
  });

  @override
  State<WallpaperGrid> createState() => _WallpaperGridState();
}

class _WallpaperGridState extends State<WallpaperGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      widget.onLoadMore?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.wallpapers.isEmpty && widget.isLoading) {
      return SliverMasonryGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childCount: 10,
        itemBuilder: (context, index) {
          return _buildShimmerItem();
        },
      );
    }

    return SliverMasonryGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childCount: widget.wallpapers.length + (widget.isLoading ? 2 : 0),
      itemBuilder: (context, index) {
        if (index >= widget.wallpapers.length) {
          return _buildShimmerItem();
        }
        return WallpaperTile(wallpaper: widget.wallpapers[index]);
      },
    );
  }

  Widget _buildShimmerItem() {
    final height = 200 + (50 * (DateTime.now().millisecondsSinceEpoch % 3));
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[50]!,
      period: const Duration(milliseconds: 1000),
      child: Container(
        height: height.toDouble(),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[300]!,
              Colors.grey[200]!,
              Colors.grey[100]!,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Shimmer for favorite button
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Shimmer for likes counter
            Positioned(
              bottom: 12,
              left: 12,
              child: Container(
                width: 60,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}