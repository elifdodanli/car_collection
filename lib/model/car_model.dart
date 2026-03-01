class CarModel {
  final String id;
  final String brand;
  final String model;
  final int year;
  final bool isFavorite;
  final String imageUrl;
  final String userId;

  CarModel({
    required this.id,
    required this.brand,
    required this.model,
    required this.year,
    required this.isFavorite,
    required this.imageUrl,
    required this.userId,
  });

  factory CarModel.fromFirestore(Map<String, dynamic> data, String id) {
    return CarModel(
      id: id,
      brand: data['brand'] ?? '',
      model: data['model'] ?? '',
      year: (data['year'] as num).toInt(),
      isFavorite: data['isFavorite'] ?? false,
      imageUrl: data['imageUrl'] ?? '',
      userId: data['userId'] ?? '',
    );
  }
}
