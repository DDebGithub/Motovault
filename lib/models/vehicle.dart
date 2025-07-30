class Vehicle {
  final int? id; // Nullable for new inserts
  final String status;
  final String purchaseDate;
  final String chassisNumber;
  final int odoReading;
  final String lastServiceDate;
  final String? imagePath;

  Vehicle({
    this.id,
    required this.status,
    required this.purchaseDate,
    required this.chassisNumber,
    required this.odoReading,
    required this.lastServiceDate,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'status': status,
      'purchaseDate': purchaseDate,
      'chassisNumber': chassisNumber,
      'odoReading': odoReading,
      'lastServiceDate': lastServiceDate,
      'imagePath': imagePath,
    };
  }
}

