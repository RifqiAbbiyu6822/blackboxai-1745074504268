class SteamGame {
  final int appId;
  final String name;
  final String headerImage;
  final String trailerUrl;
  final String steamPageUrl;

  SteamGame({
    required this.appId,
    required this.name,
    required this.headerImage,
    required this.trailerUrl,
    required this.steamPageUrl,
  });

  factory SteamGame.fromJson(Map<String, dynamic> json) {
    return SteamGame(
      appId: json['appid'],
      name: json['name'],
      headerImage: json['header_image'] ?? '',
      trailerUrl: json['trailer'] ?? '',
      steamPageUrl: 'https://store.steampowered.com/app/\${json['appid']}',
    );
  }
}
