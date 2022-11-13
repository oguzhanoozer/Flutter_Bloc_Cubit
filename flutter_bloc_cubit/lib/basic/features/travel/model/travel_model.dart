class TravelModel {
  final String title;
  final String subtitle;
  final String imageName;

  TravelModel({required this.title, required this.subtitle, required this.imageName});

  String get imagePath => 'asset/images/feed/$imageName.png';

  static final List<TravelModel> mockItems = [
    TravelModel(title: "Sapporo", subtitle: "Sopporo Tower", imageName: "discover"),
    TravelModel(title: "Osaka", subtitle: "Japan", imageName: "dest"),
    TravelModel(title: "Cosentino", subtitle: "Cosentinonoto", imageName: "cosentino"),
  ];
}

enum ImageEnums { discover, camp_alt, camp_alt2, cosentino, dest }

extension ImageEnumsExtension on ImageEnums {
  String get toPathFeed => "asset/images/feed/$name.png";
}
