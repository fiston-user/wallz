import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String imageUrl;
  final IconData icon;
  final Color color;

  const Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.icon,
    required this.color,
  });
}

class CategoryConstants {
  static const List<Category> categories = [
    Category(
      id: 'nature',
      name: 'Nature',
      imageUrl: 'https://images.unsplash.com/photo-1469474968028-56623f02e42e',
      icon: Icons.nature,
      color: Colors.green,
    ),
    Category(
      id: 'abstract',
      name: 'Abstract',
      imageUrl: 'https://images.unsplash.com/photo-1518640467707-6811f4a6ab73',
      icon: Icons.palette,
      color: Colors.purple,
    ),
    Category(
      id: 'animals',
      name: 'Animals',
      imageUrl: 'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f',
      icon: Icons.pets,
      color: Colors.orange,
    ),
    Category(
      id: 'city',
      name: 'City',
      imageUrl: 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000',
      icon: Icons.location_city,
      color: Colors.blue,
    ),
    Category(
      id: 'space',
      name: 'Space',
      imageUrl: 'https://images.unsplash.com/photo-1446776653964-20c1d3a81b06',
      icon: Icons.star,
      color: Colors.indigo,
    ),
    Category(
      id: 'technology',
      name: 'Technology',
      imageUrl: 'https://images.unsplash.com/photo-1518770660439-4636190af475',
      icon: Icons.computer,
      color: Colors.cyan,
    ),
    Category(
      id: 'minimal',
      name: 'Minimal',
      imageUrl: 'https://images.unsplash.com/photo-1494438639946-1ebd1d20bf85',
      icon: Icons.crop_square,
      color: Colors.grey,
    ),
    Category(
      id: 'cars',
      name: 'Cars',
      imageUrl: 'https://images.unsplash.com/photo-1492144534655-ae79c964c9d7',
      icon: Icons.directions_car,
      color: Colors.red,
    ),
  ];
}