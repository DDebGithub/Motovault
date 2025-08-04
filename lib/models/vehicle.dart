class Vehicle {
  final String imagePath;
  final String name;
  final String status;
  final String purchaseDate;
  final String chassisNumber;
  final int odoReading;
  final String lastServiceDate;
  final String nextServiceDate;

  Vehicle({
    required this.imagePath,
    required this.name,
    required this.status,
    required this.purchaseDate,
    required this.chassisNumber,
    required this.odoReading,
    required this.lastServiceDate,
    required this.nextServiceDate,
  });

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      imagePath: map['image'] ?? 'assets/images/gear.jpg',
      name: map['name'] ?? '',
      status: map['status'] ?? 'Offline',
      purchaseDate: map['purchaseDate'] ?? '',
      chassisNumber: map['chassisNumber'] ?? '',
      odoReading: int.tryParse(map['odoReading']?.toString() ?? '') ?? 0,
      lastServiceDate: map['lastServiceDate'] ?? '',
      nextServiceDate: map['nextServiceDate'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': imagePath,
      'name': name,
      'status': status,
      'year': purchaseDate,
      'chassis': chassisNumber,
      'odo': odoReading.toString(),
      'last_service': lastServiceDate,
      'next_service': nextServiceDate,
    };
  }
}