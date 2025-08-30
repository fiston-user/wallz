import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';
import '../providers/wallpaper_provider.dart';
import '../widgets/wallpaper_grid.dart';

class CategoryWallpapersScreen extends StatefulWidget {
  final Category category;

  const CategoryWallpapersScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryWallpapersScreen> createState() => _CategoryWallpapersScreenState();
}

class _CategoryWallpapersScreenState extends State<CategoryWallpapersScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WallpaperProvider>().loadCategoryWallpapers(
            widget.category.name,
            refresh: true,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SafeArea(
              child: Column(
                children: [
                  // Top navigation bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.category.name,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                widget.category.color,
                                widget.category.color.withValues(alpha: 0.7),
                              ],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: widget.category.color.withValues(alpha: 0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.category.icon,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Premium category banner
                  Container(
                    height: 200,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: widget.category.color.withValues(alpha: 0.3),
                          blurRadius: 24,
                          offset: const Offset(0, 12),
                          spreadRadius: 0,
                        ),
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Background image with rounded corners
                        ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  widget.category.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              // Premium gradient overlay
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(32),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.transparent,
                                      widget.category.color.withValues(alpha: 0.3),
                                      widget.category.color.withValues(alpha: 0.8),
                                      Colors.black.withValues(alpha: 0.7),
                                    ],
                                    stops: const [0.0, 0.3, 0.7, 1.0],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Floating decorative elements
                        Positioned(
                          right: 20,
                          top: 30,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0.3),
                                  Colors.white.withValues(alpha: 0.1),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          top: 20,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.6),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 60,
                          bottom: 60,
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.5),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        // Content
                        Positioned(
                          bottom: 24,
                          left: 24,
                          right: 24,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      widget.category.icon,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${widget.category.name} Collection',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 0.3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Curated ${widget.category.name} Wallpapers',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.3,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 2),
                                      blurRadius: 8,
                                      color: Colors.black45,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer<WallpaperProvider>(
            builder: (context, provider, child) {
              if (provider.error != null) {
                return SliverToBoxAdapter(
                  child: SizedBox(
                    height: 400,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 64),
                          const SizedBox(height: 16),
                          Text(provider.error!),
                          ElevatedButton(
                            onPressed: () {
                              provider.loadCategoryWallpapers(
                                widget.category.name,
                                refresh: true,
                              );
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              if (provider.categoryWallpapers.isEmpty && !provider.isLoading) {
                return const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 400,
                    child: Center(
                      child: Text('No wallpapers found in this category'),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: WallpaperGrid(
                  wallpapers: provider.categoryWallpapers,
                  isLoading: provider.isLoading,
                  onLoadMore: () {
                    if (provider.hasMore && !provider.isLoading) {
                      provider.loadCategoryWallpapers(widget.category.name);
                    }
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}