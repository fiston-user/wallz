class Wallpaper {
  final String id;
  final String description;
  final String altDescription;
  final Map<String, String> urls;
  final User user;
  final int likes;
  final int width;
  final int height;
  final String color;
  final String? blurHash;
  final DateTime createdAt;

  Wallpaper({
    required this.id,
    required this.description,
    required this.altDescription,
    required this.urls,
    required this.user,
    required this.likes,
    required this.width,
    required this.height,
    required this.color,
    this.blurHash,
    required this.createdAt,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id'] ?? '',
      description: json['description'] ?? '',
      altDescription: json['alt_description'] ?? '',
      urls: Map<String, String>.from(json['urls'] ?? {}),
      user: User.fromJson(json['user'] ?? {}),
      likes: json['likes'] ?? 0,
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      color: json['color'] ?? '#000000',
      blurHash: json['blur_hash'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  String get thumbnailUrl => urls['small'] ?? '';
  String get regularUrl => urls['regular'] ?? '';
  String get fullUrl => urls['full'] ?? '';
  String get rawUrl => urls['raw'] ?? '';
}

class User {
  final String id;
  final String username;
  final String name;
  final Map<String, String> profileImage;
  final Map<String, String> links;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.profileImage,
    required this.links,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      profileImage: Map<String, String>.from(json['profile_image'] ?? {}),
      links: Map<String, String>.from(json['links'] ?? {}),
    );
  }

  String get profileImageUrl => profileImage['medium'] ?? '';
  String get portfolioUrl => links['html'] ?? '';
}