class Restaurant {
  final String id;
  final String title;
  final String long;
  final String lat;

  const Restaurant({
    required this.id,
    required this.title,
    required this.lat,
    required this.long,
  });

  @override
  String toString() {
    return 'Restaurant{id: $id, title: $title, long: $long, lat: $lat}';
  }
}
